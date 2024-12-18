import ArgumentParser

struct Default: ParsableCommand {

    mutating func run() {
        do {
            let xcodes = try XcodeSelection.perform()
            try XcodeBluff.bluff(selectedXcode: xcodes.selected, latestXcode: xcodes.latest)
        } catch {
            write(error.localizedDescription, style: .error)
        }
    }
}
