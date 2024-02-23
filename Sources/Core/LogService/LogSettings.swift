import Foundation

internal struct LogSettings {

    // MARK: Stored Properties

    private let isLogEnabled: Bool = true
    private let debug: Bool = true
    private let api: Bool = true
    private let screen: Bool = true
    private let analytics: Bool = true

    // MARK: Public Settings

    internal var isDebugEnabled: Bool { isLogEnabled ? debug : false }
    internal var isApiEnabled: Bool { isLogEnabled ? api : false }
    internal var isScreenEnabled: Bool { isLogEnabled ? screen : false }
    internal var isAnalyticsEnabled: Bool { isLogEnabled ? screen : false }
}
