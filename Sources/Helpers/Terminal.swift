import Foundation
import ANSITerminal

enum WriteStyle {

    case success
    case error
    case warning
}

func write(_ text: String, style: WriteStyle) {
    switch style {
    case .success:
        writeln(text.green)
    case .error:
        writeln(text.red)
    case .warning:
        writeln(text.yellow)
    }
}

func step<T>(title: String, action: () throws -> T) throws -> T {
    writeln("→ \(title)".bold.lightGreen)

    do {
        return try action()
    } catch {
        write(error.localizedDescription, style: .error)
        throw error
    }
}
