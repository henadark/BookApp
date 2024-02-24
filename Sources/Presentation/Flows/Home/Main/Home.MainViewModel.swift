import Foundation
import Combine
import Domain
import Helpers
import Core
import Domain

extension Home {

    internal final class MainViewModel: ObservableObject {

        internal typealias FinishCompletion = VoidCompletion

        // MARK: Stored Properties

        // Domain
        private let booksService: BooksServiceProtocol
        internal let didFinish: FinishCompletion

        // UI

        // Helpers
        private var cancellableSet = Set<AnyCancellable>()

        // MARK: Init

        internal init(
            booksService: BooksServiceProtocol,
            didFinish: @escaping FinishCompletion
        ) {
            self.booksService = booksService
            self.didFinish = didFinish
        }

        deinit {
            cancellableSet.forEach { $0.cancel() }
        }

        // MARK: Actions

        internal func onViewDidLoad() {
        }

        internal func onAppear() {}

        internal func onDisappear() {}

        // MARK: Mock

        internal class var mock: MainViewModel{
            MainViewModel(
                booksService: MockBooksService(),
                didFinish: {}
            )
        }
    }
}
