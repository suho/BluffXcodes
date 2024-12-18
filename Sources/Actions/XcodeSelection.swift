struct XcodeSelection {

    static func perform() throws -> (selected: Xcode, latest: Xcode) {
        return try step(title: "Loading Xcode applications...") {
            let xcodes = Xcode.find().sorted(by: { $0.shortVersion < $1.shortVersion })
            if xcodes.isEmpty || xcodes.count < 1 {
                write("Required at least 2 Xcodes into your system", style: .error)
                throw Error.notFound
            }
            let selected = picker(
                title: "Select the old Xcode you want to use!",
                options: xcodes
            )
            write("Selected Xcode: \(selected.shortVersion)", style: .success)
            return (selected, xcodes.last!)
        }
    }
}
