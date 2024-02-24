import Foundation
import Core

public final class BooksService: BooksServiceProtocol {

    // MARK: Stored Properties

    private let dataProvider: DataProviderProtocol
    private var books: [BookFirebaseModel] = []
    private var topBannerSlides: [TopBannerSlideFirebaseModel] = []
    private var youWillLikeSection: [Int] = []

    // MARK: Init

    public init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }

    public func fetchBooks() async throws {

        let remoteConfig = try await dataProvider.fetchBooks()
        books = remoteConfig.books
        topBannerSlides = remoteConfig.topBannerSlides
        youWillLikeSection = remoteConfig.youWillLikeSection
    }
}
