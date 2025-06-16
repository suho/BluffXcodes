import Foundation
import ArgumentParser

@main
struct Bluffxcodes: ParsableCommand {

    static let configuration: CommandConfiguration = CommandConfiguration(
        abstract: "Bluffing your Xcode versions with ease!"
    )

    mutating func run() {
        do {
            let xcodes = try XcodeSelection.perform()
#if canImport(AppKit)
            try XcodeBluff.bluff(selectedXcode: xcodes.selected, latestXcode: xcodes.latest)
#endif
        } catch {
            write(error.localizedDescription, style: .error)
        }
    }
}
