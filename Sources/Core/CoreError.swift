import Foundation

public enum CoreError: Error, LocalizedError, CustomLocalizedStringResourceConvertible {

    case failedFetchFirebaseRemoteConfig
    case unknown(message: String?)

    // MARK: LocalizedError

    public var errorDescription: String? {
        switch self {
        case .failedFetchFirebaseRemoteConfig:
            return "Failed to fetch remote config from Firebase"
        case let .unknown(message):
            return message ?? "Unknown Error"
        }
    }

    // MARK: CustomLocalizedStringResourceConvertible

    public var localizedStringResource: LocalizedStringResource {
        LocalizedStringResource(stringLiteral: errorDescription ?? "")
    }
}
