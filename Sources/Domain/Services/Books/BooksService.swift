import Foundation
import Core
import Resources

internal final class BooksService: Sendable, BooksServiceProtocol {

    internal actor Repository {

        // MARK: Stored Properties

        internal var booksByGenre: BooksByGenreDomainModel
        internal var topBannerSlides: [TopBannerSlideFirebaseModel]
        internal var youWillLikeSection: [Int]
        internal var booksDetails: [BookFirebaseModel]

        // MARK: Init

        internal init(
            booksByGenre: BooksByGenreDomainModel = [:],
            topBannerSlides: [TopBannerSlideFirebaseModel] = [],
            youWillLikeSection: [Int] = [],
            booksDetails: [BookFirebaseModel] = []
        ) {
            self.booksByGenre = booksByGenre
            self.topBannerSlides = topBannerSlides
            self.youWillLikeSection = youWillLikeSection
            self.booksDetails = booksDetails
        }

        // MARK: Data Updates

        internal func uodate(
            booksByGenre: BooksByGenreDomainModel,
            topBannerSlides: [TopBannerSlideFirebaseModel],
            youWillLikeSection: [Int],
            booksDetails: [BookFirebaseModel]
        ) {
            self.booksByGenre = booksByGenre
            self.topBannerSlides = topBannerSlides
            self.youWillLikeSection = youWillLikeSection
            self.booksDetails = booksDetails
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
        let mainBooks = remoteConfig.main

        let builder = BooksByGenreDomainModelBuilder()
        let booksByGenre = builder.build(from: mainBooks.books)

        await repository.uodate(
            booksByGenre: booksByGenre,
            topBannerSlides: mainBooks.topBannerSlides,
            youWillLikeSection: mainBooks.youWillLikeSection,
            booksDetails: remoteConfig.booksDetails.items
        )
    }

    public var booksByGenre: BooksByGenreDomainModel {
        get async  {
            await repository.booksByGenre
        }
    }

    public var topBannerSlides: [TopBannerSlideFirebaseModel] {
        get async  {
            await repository.topBannerSlides
        }
    }

    public var youWillLikeSection: [BookFirebaseModel] {
        get async  {

            let section = await repository.youWillLikeSection
            let books = await repository.booksByGenre.values.flatMap { $0 }

            var filteredBooks = [BookFirebaseModel]()
            section.forEach { id in
                if let book = books.first(where: { $0.id == id }) {
                    filteredBooks.append(book)
                }
            }

            return filteredBooks
        }
    }

    public var booksDetails: [BookFirebaseModel] {
        get async  {
            await repository.booksDetails
        }
    }
}
