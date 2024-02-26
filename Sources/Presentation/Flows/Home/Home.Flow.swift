import SwiftUI
import Helpers
import Core

extension Home {

    internal struct Flow: View {

        internal typealias FinishCompletion = VoidCompletion

        internal enum Screen: Hashable, Identifiable {

            case main
            case bookDetails(bookId: Int)

            public var id: String { String(describing: self) }
        }

        // MARK: Stored Properties

        @State private var navigationPath = [Screen]()
        private let startScreen: Screen

        private let viewFactory: ViewFactory

        private var didFinish: FinishCompletion

        // MARK: Init

        internal init(
            startScreen: Screen,
            viewFactory: ViewFactory,
            didFinish: @escaping FinishCompletion
        ) {
            self.startScreen = startScreen
            self.viewFactory = viewFactory
            self.didFinish = didFinish
        }

        // MARK: View

        internal var body: some View {
            NavigationStack(path: $navigationPath) {
                content(screen: startScreen)
                    .navigationDestination(for: Screen.self, destination: content)
            }
        }

        @ViewBuilder private func content(screen: Screen) -> some View {
            switch screen {
            case .main:
                mainView()
            case let .bookDetails(id):
                bookDetailsView(bookId: id)
            }
        }

        private func mainView() -> some View {
            viewFactory.main { status in
                switch status {
                case let .selectBook(id):
                    push(.bookDetails(bookId: id))
                }
            }
        }

        private func bookDetailsView(bookId: Int) -> some View {
            viewFactory.bookDetails(bookId: bookId) {
                popToRoot()
            }
        }

        // MARK: Navigation

        private var currentScreen: Screen { navigationPath.last ?? startScreen }

        private func push(_ screen: Screen) {
            navigationPath.append(screen)
            Log.screen("\(screen) is pushed")
        }

        private func popToRoot() {
            navigationPath.removeAll()
            Log.screen("Pop to \(startScreen)")
        }
    }
}

