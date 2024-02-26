import Foundation
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift

public actor DataProvider: DataProviderProtocol {

    // MARK: Stored Properties

    private let remoteConfig: RemoteConfig

    // MARK: Init

    public init(remoteConfig: RemoteConfig) {
        self.remoteConfig = remoteConfig
    }

    public func fetchBooks() async throws -> RemoteConfigFirebaseModel {

        let status = try await remoteConfig.fetchAndActivate()

        switch status {
        case .successFetchedFromRemote, .successUsingPreFetchedData:
            return try remoteConfig.decoded()
        case .error:
            throw CoreError.failedFetchFirebaseRemoteConfig
        @unknown default:
            throw CoreError.unknown(message: "Unknown status after fetching and activativating remote config")
        }
    }
}
