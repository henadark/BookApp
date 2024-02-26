import Foundation
import SwiftExtensions
import Helpers
import Core
import Domain

extension Home {

    internal final class BookDetailsViewModel: ObservableObject {

        internal typealias FinishCompletion = VoidCompletion

        // MARK: Stored Properties

        // Domain
        private let booksService: BooksServiceProtocol
        private let bookId: Int
        internal let didFinish: FinishCompletion

        // UI
        internal private(set) var youWillLikeSection: [BookFirebaseModel] = []
        internal private(set) var books: [BookFirebaseModel] = []

        @Published internal var currentSelectedIndex: Int = 0
        internal var currentBook: BookFirebaseModel? { books[safe: currentSelectedIndex] }
        internal var currentAuthorName: String { books[safe: currentSelectedIndex]?.author ?? "" }
        internal var currentBookName: String { books[safe: currentSelectedIndex]?.name ?? "" }

        // MARK: Init

        internal init(
            booksService: BooksServiceProtocol,
            selectBookId: Int,
            didFinish: @escaping FinishCompletion
        ) {
            self.booksService = booksService
            self.bookId = selectBookId
            self.didFinish = didFinish

            Task { [weak self] in
                await self?.updateData()
            }
        }

        // MARK: Setup

        @MainActor
        private func updateData() async {
            
            let booksDetails = await booksService.booksDetails
            let section = await booksService.youWillLikeSection
            let index = booksDetails.firstIndex(where: { $0.id == bookId }) ?? 0

            books = booksDetails
            youWillLikeSection = section
            currentSelectedIndex = index
        }

        // MARK: Actions

        internal func onBackButtonTap() {
            didFinish()
        }

        internal func onReadNowButtonTap() {
            print("Hello 🙂")
        }

        // MARK: Mock

        internal class var mock: BookDetailsViewModel{
            BookDetailsViewModel(
                booksService: MockBooksService.mock,
                selectBookId: 1,
                didFinish: { }
            )
        }
    }
}
