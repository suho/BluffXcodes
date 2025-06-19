import Foundation

enum LogLevel: String {
    case info
    case success
    case warning
    case error
}

final class Logger {
    static let shared = Logger()

    var verbose: Bool = false
    private let logURL: URL
    private let formatter: ISO8601DateFormatter

    private init() {
        let logDir = FileManager.default.homeDirectoryForCurrentUser
            .appending(path: "Library/Logs", directoryHint: .isDirectory)
        try? FileManager.default.createDirectory(at: logDir, withIntermediateDirectories: true)
        logURL = logDir.appending(path: "bluffxcodes.log")
        formatter = ISO8601DateFormatter()
    }

    func log(_ message: String, level: LogLevel = .info) {
        let entry: [String: String] = [
            "timestamp": formatter.string(from: Date()),
            "level": level.rawValue,
            "message": message
        ]
        if let data = try? JSONSerialization.data(withJSONObject: entry),
           let json = String(data: data, encoding: .utf8) {
            if let handle = try? FileHandle(forWritingTo: logURL) {
                handle.seekToEndOfFile()
                if let lineData = (json + "\n").data(using: .utf8) {
                    handle.write(lineData)
                }
                try? handle.close()
            } else {
                try? json.appending("\n").write(to: logURL, atomically: true, encoding: .utf8)
            }
        }
        if verbose {
            print("LOG[\(level.rawValue.uppercased())]: \(message)")
        }
    }
}
