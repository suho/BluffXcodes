import Foundation
import Version

struct Xcode: Titlable {


    let appName: String
    let version: Version
    let path: URL

    var title: String {
        "\(appName) (Version: \(version))"
    }
}

extension Xcode {

    static func find() -> [Xcode] {
        let fileManager = FileManager.default
        let xcodeBundleId = "com.apple.dt.Xcode"
        let applicationsPath = "/Applications"

        guard let enumerator = fileManager.enumerator(atPath: applicationsPath) else {
            print("Could not access ~/Applications directory")
            return []
        }

        var xcodeApps: [Xcode] = []
        
        while let filePath = enumerator.nextObject() as? String {
            if filePath.contains("/") || !filePath.hasPrefix("Xcode") { continue }
            let fullPath = (applicationsPath as NSString).appendingPathComponent(filePath)
            if let bundle = Bundle(path: fullPath),
               let bundleId = bundle.bundleIdentifier,
               bundleId == xcodeBundleId,
               var version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String {
                if version.split(separator: ".").count == 2 {
                    version += ".0"
                }
                if let version = Version(version), let path = URL(string: fullPath) {
                    xcodeApps.append(.init(appName: filePath, version: version, path: path))
                }
            }
        }

        return xcodeApps
    }
}
