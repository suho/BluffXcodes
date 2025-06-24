import Foundation
import Version

enum Constants {

    static let applicationsPath = "/Applications"
    static let xcodeBundleID = "com.apple.dt.Xcode"
    static let bundleVersion = "CFBundleVersion"
    static let shortVersion = "CFBundleShortVersionString"

    // Mapping between macOS major versions and their supported Xcode versions.
    // Older Xcodes will be updated to use the listed build numbers.
    private static let supportedXcodes: [Int: (version: Version, build: String)] = [
        26: (version: Version("16.4")!, build: "23792"),
        15: (version: Version("16.4")!, build: "23792"),
        14: (version: Version("15.4")!, build: "22622"),
        13: (version: Version("14.3.1")!, build: "21815")
    ]

    static var currentSupported: (version: Version, build: String)? {
        supportedXcodes[ProcessInfo.processInfo.operatingSystemVersion.majorVersion]
    }
}
