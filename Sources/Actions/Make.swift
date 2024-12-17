import ArgumentParser

struct Make: ParsableCommand {

    @Option(help: "Select the xcode you want to open!")
    var oldXcode: String?

    mutating func run() {
        XcodeSelection().perform()
    }
}
