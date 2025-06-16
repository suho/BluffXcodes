import Foundation
#if canImport(AppKit)
import AppKit
#endif

#if canImport(AppKit)
struct XcodeBluff {

    static func bluff(selectedXcode: Xcode, latestXcode: Xcode) throws {
        try step(title: "Bluffing Xcode applications...") {
            guard selectedXcode.url.startAccessingSecurityScopedResource() else { return }

            try update(bundleVersion: latestXcode.bundleVersion, to: selectedXcode.url)

            NSWorkspace.shared.open(selectedXcode.url)
            DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
                NSRunningApplication.runningApplications(withBundleIdentifier: Constants.xcodeBundleID).first { app in
                    return app.bundleURL == selectedXcode.url
                }?.forceTerminate()
            }

            try update(bundleVersion: selectedXcode.bundleVersion, to: selectedXcode.url)

            selectedXcode.url.stopAccessingSecurityScopedResource()
            latestXcode.url.stopAccessingSecurityScopedResource()
        }
    }

    private static func update(bundleVersion: String, to url: URL) throws {
        let infoPlistUrl = url.appending(path: "/Contents/Info.plist")
        guard var dict = try Dictionary<String, AnyObject>.contentsOf(path: infoPlistUrl) else {
            throw Error.custom("Could not read Info.plist at \(infoPlistUrl)")
        }
        dict[Constants.bundleVersion] = bundleVersion as AnyObject
        let data = try PropertyListSerialization.data(fromPropertyList: dict, format: .xml, options: 0)
        try data.write(to: infoPlistUrl)
    }
}
#endif

extension Dictionary {

    static func contentsOf(path: URL) throws -> Dictionary<String, AnyObject>? {
        let data = try Data(contentsOf: path)
        let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)

        return plist as? [String: AnyObject]
    }
}
