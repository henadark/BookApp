import Foundation
import os
import SwiftExtensions

public final class LogService {

    public enum Event: String {
       case e = "📕" // error
       case d = "📘" // debug
       case w = "⚠️" // warning
    }

    // MARK: Stored Properties

    private let settings: LogSettings

    private let subsystem = Bundle.main.bundleIdentifier ?? "-"

    private lazy var debugLog: Logger = {
        Logger(subsystem: subsystem, category: "DEBUG")
    }()
    private lazy var apiLog: Logger = {
        Logger(subsystem: subsystem, category: "API")
    }()
    private lazy var screenLog: Logger = {
        Logger(subsystem: subsystem, category: "SCREEN")
    }()

    // MARK: Init

    fileprivate init(settings: LogSettings) {
        self.settings = settings
    }

    // MARK: Loggers

    public func debug(
        event: Event = .d,
        isDetailed: Bool = false,
        level: OSLogType = .debug,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line,
        _ message: String
    ) {

        guard settings.isDebugEnabled else { return }

        log(
            from: &debugLog,
            isDetailed: isDetailed,
            event: event,
            level: level,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber,
            message
        )
    }

    public func api(
        event: Event = .d,
        isDetailed: Bool = false,
        level: OSLogType = .debug,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line,
        _ data: Data
    ) {

        guard settings.isApiEnabled else { return }

        let message = data.prettyPrintedJSONString ?? "Response Data is empty"

        log(
            from: &apiLog,
            isDetailed: isDetailed,
            event: event,
            level: level,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber,
            "RESPONSE:\n\(message)"
        )
    }

    public func api(
        event: Event = .d,
        isDetailed: Bool = false,
        level: OSLogType = .debug,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line,
        _ message: String
    ) {

        guard settings.isApiEnabled else { return }

        log(
            from: &apiLog,
            isDetailed: isDetailed,
            event: event,
            level: level,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber,
            message
        )
    }

    public func screen(
        event: Event = .d,
        isDetailed: Bool = false,
        level: OSLogType = .debug,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line,
        _ message: String
    ) {

        guard settings.isScreenEnabled else { return }

        log(
            from: &screenLog,
            isDetailed: isDetailed,
            event: event,
            level: level,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber,
            message
        )
    }

    private func log(
        from logger: inout Logger,
        isDetailed: Bool,
        event: Event,
        level: OSLogType,
        fileName: String,
        functionName: String,
        lineNumber: Int,
        _ message: String
    ) {
        let symbol = event.rawValue
        var text: String
        if isDetailed {
            text = "\n\(symbol) [START]:\n\(message)\n\(symbol) [THREAD]: \(currentThread)\n\(symbol) [FILE]: \(extractFileName(from: fileName))\n\(symbol) [FUNCTION]: \(functionName)\n\(symbol) [LINE]: \(lineNumber)\n\(symbol) [END]\n"
        } else {
            text = "\n\(symbol) [START]:\n\(message)\n\(symbol) [END]\n"
        }

        logger.log(level: level, "\(text)")
    }

    // MARK: Helpers

    private var currentThread: String {
        if Thread.isMainThread {
            return "main"
        } else {
            if let threadName = Thread.current.name, !threadName.isEmpty {
                return"\(threadName)"
            } else if let queueName = String(validatingUTF8: __dispatch_queue_get_label(nil)), !queueName.isEmpty {
                return"\(queueName)"
            } else {
                return String(format: "%p", Thread.current)
            }
        }
    }

    private func extractFileName(from path: String) -> String {
        path.components(separatedBy: "/").last ?? path
    }
}

// MARK: - Public Access to Logger

public private(set) var Log: LogService = LogService(settings: LogSettings())
