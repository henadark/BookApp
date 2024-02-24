import Foundation
import FirebaseRemoteConfig

public actor DataProvider: DataProviderProtocol {

    // MARK: Stored Properties

    private let remoteConfig: RemoteConfig
    private let configDataKey: String

    // MARK: Init

    public init(remoteConfig: RemoteConfig, configDataKey: String) {
        self.remoteConfig = remoteConfig
        self.configDataKey = configDataKey
    }

    public func fetchBooks() async throws -> RemoteConfigFirebaseModel {

        let status = try await remoteConfig.fetchAndActivate()

        switch status {
        case .successFetchedFromRemote, .successUsingPreFetchedData:
            return try remoteConfig[configDataKey].decoded(asType: RemoteConfigFirebaseModel.self)
        case .error:
            throw CoreError.failedFetchFirebaseRemoteConfig
        @unknown default:
            throw CoreError.unknown(message: "Unknown status after fetching and activativating remote config")
        }
    }
}
