import Foundation
import Core

internal final class BooksService: Sendable, BooksServiceProtocol {

    internal actor Repository {

        // MARK: Stored Properties

        internal var booksByGenre: BooksByGenreDomainModel
        internal var topBannerSlides: [TopBannerSlideFirebaseModel]
        internal var youWillLikeSection: [Int]

        // MARK: Init

        internal init(
            booksByGenre: BooksByGenreDomainModel = [:],
            topBannerSlides: [TopBannerSlideFirebaseModel] = [],
            youWillLikeSection: [Int] = []
        ) {
            self.booksByGenre = booksByGenre
            self.topBannerSlides = topBannerSlides
            self.youWillLikeSection = youWillLikeSection
        }

        // MARK: Data Updates

        internal func uodate(
            booksByGenre: BooksByGenreDomainModel,
            topBannerSlides: [TopBannerSlideFirebaseModel],
            youWillLikeSection: [Int]
        ) {
            self.booksByGenre = booksByGenre
            self.topBannerSlides = topBannerSlides
            self.youWillLikeSection = youWillLikeSection
        }
    }

    // MARK: Stored Properties

    private let dataProvider: DataProviderProtocol

    private let repository: Repository

    // MARK: Init

    internal init(dataProvider: DataProviderProtocol, repository: Repository = Repository()) {
        self.dataProvider = dataProvider
        self.repository = repository
    }

    public func fetchBooks() async throws {

        let remoteConfig = try await dataProvider.fetchBooks()

        let builder = BooksByGenreDomainModelBuilder()
        let booksByGenre = builder.build(from: remoteConfig.books)

        await repository.uodate(
            booksByGenre: booksByGenre,
            topBannerSlides: remoteConfig.topBannerSlides,
            youWillLikeSection: remoteConfig.youWillLikeSection
        )
    }
}
