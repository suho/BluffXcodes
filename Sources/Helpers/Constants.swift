import Foundation
import Version

enum Constants {

    static let applicationsPath = "/Applications"
    static let xcodeBundleID = "com.apple.dt.Xcode"
    static let bundleVersion = "CFBundleVersion"
    static let shortVersion = "CFBundleShortVersionString"

    private static let supportedXcodes: [Int: (version: Version, build: String)] = [
        26: (version: Version("16.4")!, build: "23792"),
        15: (version: Version("15.4")!, build: "23065"),
        14: (version: Version("15.1")!, build: "22939"),
        13: (version: Version("14.3")!, build: "22733"),
        12: (version: Version("13.4")!, build: "20503")
    ]

    static var currentSupported: (version: Version, build: String)? {
        supportedXcodes[ProcessInfo.processInfo.operatingSystemVersion.majorVersion]
    }
}
