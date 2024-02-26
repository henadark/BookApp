import SwiftUI
import Domain
import Helpers

extension Root {

    internal final class SplashViewModel: ObservableObject {

        internal typealias FinishCompletion = VoidCompletion

        // MARK: Stored Properties

        // Domain
        private let booksService: BooksServiceProtocol
        internal let didFinish: FinishCompletion

        // UI
        @Published internal var progress: Double = 0

        // MARK: Init

        internal init(
            booksService: BooksServiceProtocol,
            didFinish: @escaping FinishCompletion
        ) {
            self.booksService = booksService
            self.didFinish = didFinish
        }

        // MARK: Actions

        @MainActor
        internal func startLoading() async {

            async let animateProgressTask: Void = animateProgreess(1)
            async let fetchBooksTask: Void = try booksService.fetchBooks()
            do {
                let (_, _) = try await (animateProgressTask, fetchBooksTask)
                didFinish()
            } catch {}
        }

        @MainActor
        private func animateProgreess(_ newProgress: Double) async {

            await withUnsafeContinuation { (continuation: UnsafeContinuation<Void, Never>) in
                withAnimation(.easeInOut(duration: 2)) {
                    progress = newProgress
                } completion: {
                    continuation.resume()
                }
            }
        }

        // MARK: Mock

        internal class var mock: SplashViewModel{
            SplashViewModel(
                booksService: MockBooksService.mock,
                didFinish: {}
            )
        }
    }
}
