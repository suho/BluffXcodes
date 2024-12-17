class XcodeSelection {
    
    private var xcode: Xcode?
    
    func perform() {
        do {
            try step(title: "Loading Xcode applications for selection") {
                let xcodes = Xcode.find().sorted(by: { $0.version < $1.version })
                if xcodes.isEmpty || xcodes.count < 1 {
                    write("Required at least 2 Xcodes into your system", style: .error)
                    return
                }
                xcode = picker(
                    title: "Select the old Xcode you want to use!",
                    options: xcodes
                )
                write("Selected Xcode: \(xcode!.version)", style: .success)
            }
        } catch {}
    }
}
