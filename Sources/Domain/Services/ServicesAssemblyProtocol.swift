import Foundation
import Core

public protocol ServicesAssemblyProtocol {

    var appLocalSettingsService: AppLocalSettingsServiceProtocol { get }
    var booksService: BooksServiceProtocol { get }
}
