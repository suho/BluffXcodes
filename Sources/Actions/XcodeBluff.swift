import Foundation
#if canImport(AppKit)
import AppKit
#endif

struct XcodeBluff {

    private static func bluff(selectedXcode: Xcode, buildNumber: String) throws {
        try step(title: "Bluffing Xcode applications...") {
#if canImport(AppKit)
            guard selectedXcode.url.startAccessingSecurityScopedResource() else {
                throw Error.custom("Could not access Xcode applications. Ensure the tool has Full Disk Access.")
            }

            try update(bundleVersion: buildNumber, to: selectedXcode.url)

            NSWorkspace.shared.open(selectedXcode.url)
            DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
                NSRunningApplication.runningApplications(withBundleIdentifier: Constants.xcodeBundleID).first { app in
                    return app.bundleURL == selectedXcode.url
                }?.forceTerminate()
            }

            try update(bundleVersion: selectedXcode.bundleVersion, to: selectedXcode.url)

            selectedXcode.url.stopAccessingSecurityScopedResource()
#endif
        }
    }

    static func bluffAll(xcodes: [Xcode]) throws -> [Xcode] {
        return try step(title: "Bluffing Xcode applications...") {
            guard let support = Constants.currentSupported else {
                write("Unsupported macOS version", style: .error)
                return []
            }
            let older = xcodes.filter { $0.shortVersion < support.version }
            var opened: [Xcode] = []
            for xcode in older {
                do {
                    try bluff(selectedXcode: xcode, buildNumber: support.build)
                    opened.append(xcode)
                } catch {
                    write("Failed to open \(xcode.shortVersion)", style: .warning)
                }
            }
            let versions = opened.map { $0.shortVersion.description }.joined(separator: ", ")
            write("Successfully opened: \(versions)", style: .success)
            return opened
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

extension Dictionary {

    static func contentsOf(path: URL) throws -> Dictionary<String, AnyObject>? {
        let data = try Data(contentsOf: path)
        let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)

        return plist as? [String: AnyObject]
    }
}
