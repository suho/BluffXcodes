struct XcodeSelection {

    static func loadAll() throws -> [Xcode] {
        return try step(title: "Loading Xcode applications in background...") {
            var xcodes: [Xcode] = []
            let group = DispatchGroup()
            group.enter()
            DispatchQueue.global().async {
                xcodes = Xcode.find().sorted(by: { $0.shortVersion < $1.shortVersion })
                group.leave()
            }
            group.wait()
            if xcodes.count < 2 {
                write("Required at least 2 Xcodes into your system", style: .error)
                throw Error.notFound
            }
            return xcodes
        }
    }
}
