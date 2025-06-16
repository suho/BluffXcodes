import XCTest
@testable import bluffxcodes
import Version

final class BluffXcodesTests: XCTestCase {
    func testStepReturnsValue() throws {
        let value = try step(title: "Test") { return 42 }
        XCTAssertEqual(value, 42)
    }

    func testStepThrows() {
        enum SampleError: Swift.Error { case fail }
        XCTAssertThrowsError(try step(title: "Fail") { throw SampleError.fail })
    }

    func testDictionaryContents() throws {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appending(path: "test.plist")
        let original: [String: Any] = [
            "A": 1,
            "B": "two"
        ]
        let data = try PropertyListSerialization.data(fromPropertyList: original, format: .xml, options: 0)
        try data.write(to: url)
        let result = try Dictionary<String, AnyObject>.contentsOf(path: url)
        XCTAssertEqual(result?["A"] as? Int, 1)
        XCTAssertEqual(result?["B"] as? String, "two")
    }

    func testXcodeFind() throws {
        let apps = URL(fileURLWithPath: Constants.applicationsPath)
        try? FileManager.default.removeItem(at: apps)
        try FileManager.default.createDirectory(at: apps, withIntermediateDirectories: true)

        func createApp(name: String, short: String, build: String) throws {
            let contents = apps.appending(path: name).appending(path: "Contents")
            try FileManager.default.createDirectory(at: contents, withIntermediateDirectories: true)
            let infoURL = contents.appending(path: "Info.plist")
            let dict: [String: Any] = [
                "CFBundleIdentifier": Constants.xcodeBundleID,
                "CFBundleShortVersionString": short,
                "CFBundleVersion": build
            ]
            let data = try PropertyListSerialization.data(fromPropertyList: dict, format: .xml, options: 0)
            try data.write(to: infoURL)
        }

        try createApp(name: "Xcode1.app", short: "1.0", build: "1")
        try createApp(name: "Xcode2.app", short: "2.0", build: "2")

        let found = Xcode.find().sorted { $0.appName < $1.appName }
        XCTAssertEqual(found.count, 2)
        XCTAssertEqual(found[0].appName, "Xcode1.app")
        XCTAssertEqual(found[1].shortVersion, Version("2.0.0")!)
    }
}
