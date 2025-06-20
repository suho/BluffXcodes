import Foundation
import AppKit

struct XcodeBluff {

    private static func bluff(selectedXcode: Xcode, latestXcode: Xcode) throws {
        try step(title: "Bluffing Xcode applications...") {
            guard selectedXcode.url.startAccessingSecurityScopedResource(),
                  latestXcode.url.startAccessingSecurityScopedResource() else {
                throw Error.custom("Could not access Xcode applications. Ensure the tool has Full Disk Access.")
            }

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

    static func bluffAll(xcodes: [Xcode]) throws -> [Xcode] {
        return try step(title: "Bluffing Xcode applications...") {
            guard let latest = xcodes.last else { return [] }
            var opened: [Xcode] = []
            for xcode in xcodes.dropLast() {
                do {
                    try bluff(selectedXcode: xcode, latestXcode: latest)
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
