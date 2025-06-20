import Foundation
import ArgumentParser

@main
struct Bluffxcodes: ParsableCommand {

    static let configuration: CommandConfiguration = CommandConfiguration(
        abstract: "Bluffing your Xcode versions with ease!"
    )

    @Flag(name: .shortAndLong, help: "Enable verbose logging")
    var verbose: Bool = false

    mutating func run() {
        Logger.shared.verbose = verbose
        Logger.shared.log("Running bluffxcodes", level: .info)
        do {
            let xcodes = try XcodeSelection.loadAll()
            _ = try XcodeBluff.bluffAll(xcodes: xcodes)
        } catch {
            write(error.localizedDescription, style: .error)
        }
    }
}
