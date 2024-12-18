import Foundation
import ArgumentParser

@main
struct Main: ParsableCommand {

    static let configuration: CommandConfiguration = CommandConfiguration(
        abstract: "Bluffing your Xcode versions with ease!",
        subcommands: [Default.self],
        defaultSubcommand: Default.self
    )
}
