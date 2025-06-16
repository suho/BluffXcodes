import Foundation
import ArgumentParser

@main
struct Bluffxcodes: ParsableCommand {

    static let configuration: CommandConfiguration = CommandConfiguration(
        abstract: "Bluffing your Xcode versions with ease!"
    )

    mutating func run() {
        do {
            let xcodes = try XcodeSelection.loadAll()
            _ = try XcodeBluff.bluffAll(xcodes: xcodes)
        } catch {
            write(error.localizedDescription, style: .error)
        }
    }
}
