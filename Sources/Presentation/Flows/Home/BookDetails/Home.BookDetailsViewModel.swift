import Foundation
import Domain
import Helpers
import Core
import Domain

extension Home {

    internal final class BookDetailsViewModel: ObservableObject {

        internal typealias FinishCompletion = VoidCompletion

        // MARK: Stored Properties

        // Domain
        private let booksService: BooksServiceProtocol
//        private let bookId: Int
        internal let didFinish: FinishCompletion

        // UI
        @Published internal var booksByGenre: BooksByGenreDomainModel?
        @Published internal var topBannerSlides: [TopBannerSlideFirebaseModel] = []
        internal var genres: [BookGenreFirebaseModel] {
            guard let booksByGenre = booksByGenre else { return [] }
            return Array(booksByGenre.keys)
        }

        // MARK: Init

        internal init(
            booksService: BooksServiceProtocol,
            didFinish: @escaping FinishCompletion
        ) {
            self.booksService = booksService
            self.didFinish = didFinish

            Task { [weak self] in
                await self?.updateData()
            }
        }

        // MARK: Setup

        @MainActor
        private func updateData() async {

            booksByGenre = await booksService.booksByGenre
            topBannerSlides = await booksService.topBannerSlides
        }

        // MARK: Actions

        internal func onBackButtonTap() {
            didFinish()
        }

        internal func onBookTap(bookId: Int) {
        }

        // MARK: Mock

        internal class var mock: BookDetailsViewModel{
            BookDetailsViewModel(
                booksService: MockBooksService.mock,
                didFinish: { }
            )
        }
    }
}
