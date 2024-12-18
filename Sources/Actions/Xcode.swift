import Foundation
import Version

struct Xcode: Titlable {

    let appName: String
    let shortVersion: Version
    let bundleVersion: String
    let url: URL

    var title: String {
        "\(appName) (Version: \(shortVersion.description) Build: \(bundleVersion))"
    }
}

extension Xcode {

    static func find() -> [Xcode] {
        guard let enumerator = FileManager.default.enumerator(atPath: Constants.applicationsPath) else {
            write("Could not access ~/Applications directory", style: .error)
            exit(1)
        }

        var xcodeApps: [Xcode] = []
        
        while let filePath = enumerator.nextObject() as? String {
            if filePath.contains("/") || !filePath.hasPrefix("Xcode") { continue }
            let fullPath = (Constants.applicationsPath as NSString).appendingPathComponent(filePath)
            if let bundle = Bundle(path: fullPath),
               let bundleId = bundle.bundleIdentifier,
               bundleId == Constants.xcodeBundleID,
               let infoDictionary = bundle.infoDictionary,
               var shortVersion = infoDictionary[Constants.shortVersion] as? String,
               let bundleVersion = infoDictionary[Constants.bundleVersion] as? String {
                if shortVersion.split(separator: ".").count == 2 {
                    shortVersion += ".0"
                }
                if let version = Version(shortVersion),
                   let path = URL(string: fullPath),
                   let url = URL(string: "file://\(path.absoluteString)/"),
                   url.startAccessingSecurityScopedResource() {
                    xcodeApps.append(
                        .init(appName: filePath, shortVersion: version, bundleVersion: bundleVersion, url: url)
                    )
                }
            }
        }

        return xcodeApps
    }
}
