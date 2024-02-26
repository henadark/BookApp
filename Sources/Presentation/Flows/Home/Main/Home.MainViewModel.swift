import Foundation
import Domain
import Helpers
import Core
import Domain

extension Home {

    internal final class MainViewModel: ObservableObject {

        public enum FinishStatus {
            case selectBook(id: Int)
        }

        internal typealias FinishCompletion = (FinishStatus) -> Void

        // MARK: Stored Properties

        // Domain
        private let booksService: BooksServiceProtocol
        internal let didFinish: FinishCompletion

        // UI
        @Published internal var booksByGenre: BooksByGenreDomainModel?
        @Published internal var topBannerSlides: [TopBannerSlideFirebaseModel] = []
        internal let autoScrollBannerTimeInterval: TimeInterval
        internal var genres: [BookGenreFirebaseModel] {
            guard let booksByGenre = booksByGenre else { return [] }
            return Array(booksByGenre.keys)
        }

        // MARK: Init

        internal init(
            booksService: BooksServiceProtocol,
            autoScrollBannerTimeInterval: TimeInterval,
            didFinish: @escaping FinishCompletion
        ) {
            self.booksService = booksService
            self.autoScrollBannerTimeInterval = autoScrollBannerTimeInterval
            self.didFinish = didFinish

            Task { [weak self] in
                await self?.updateData()
            }
        }

        // MARK: Setup

        @MainActor
        private func updateData() async {

            let books = await booksService.booksByGenre
            let slides = await booksService.topBannerSlides
            booksByGenre = books
            topBannerSlides = slides
        }

        // MARK: Actions

        internal func onBannerTap(bookId: Int) {
            didFinish(.selectBook(id: bookId))
        }

        internal func onBookTap(bookId: Int) {
            didFinish(.selectBook(id: bookId))
        }

        // MARK: Mock

        internal class var mock: MainViewModel{
            MainViewModel(
                booksService: MockBooksService.mock,
                autoScrollBannerTimeInterval: 3.0,
                didFinish: { _ in }
            )
        }
    }
}
