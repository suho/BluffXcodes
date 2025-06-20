import Foundation
import ANSITerminal

enum WriteStyle {

    case info
    case success
    case error
    case warning
}

func write(_ text: String, style: WriteStyle) {
    switch style {
    case .info:
        writeln(text)
        Logger.shared.log(text, level: .info)
    case .success:
        writeln(text.green)
        Logger.shared.log(text, level: .success)
    case .error:
        writeln(text.red)
        Logger.shared.log(text, level: .error)
    case .warning:
        writeln(text.yellow)
        Logger.shared.log(text, level: .warning)
    }
}

func step<T>(title: String, action: () throws -> T) throws -> T {
    writeln("→ \(title)".bold.lightGreen)
    Logger.shared.log(title, level: .info)

    do {
        return try action()
    } catch {
        write(error.localizedDescription, style: .error)
        Logger.shared.log(error.localizedDescription, level: .error)
        throw error
    }
}
