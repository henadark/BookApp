import Foundation
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift
import Core

public final class ServicesAssembly: ServicesAssemblyProtocol {

    // MARK: Stored Properties

    private let dataProvider: DataProviderProtocol
    public let appLocalSettingsService: AppLocalSettingsServiceProtocol
    public let booksService: BooksServiceProtocol

    // MARK: Init

    public init() {
        
        appLocalSettingsService = AppLocalSettingsService()
        dataProvider = DataProvider(remoteConfig: RemoteConfig.remoteConfig())

        booksService = BooksService(dataProvider: dataProvider)
    }
}
