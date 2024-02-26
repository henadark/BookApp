import Foundation
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift
import Core

public final class ServicesAssembly: ServicesAssemblyProtocol {

    // MARK: Stored Properties

    private let appLocalSettingsService: AppLocalSettingsServiceProtocol
    private let dataProvider: DataProviderProtocol
    public let booksService: BooksServiceProtocol

    // MARK: Init

    public init() {
        
        appLocalSettingsService = AppLocalSettingsService()
        dataProvider = DataProvider(
            remoteConfig: RemoteConfig.remoteConfig(),
            configDataKey: appLocalSettingsService.firebaseRemoteConfigKey
        )

        booksService = BooksService(dataProvider: dataProvider)
    }
}
