import SwiftUI

extension Home {

    internal final class ViewFactory {

        // MARK: Stored Properties

        private let viewModelFactory: ViewModelFactory

        // MARK: Init

        internal init(viewModelFactory: ViewModelFactory) {
            self.viewModelFactory = viewModelFactory
        }

        // MARK: Views

        internal func main(didFinish: @escaping MainViewModel.FinishCompletion) -> some View {
            return MainView(viewModel: self.viewModelFactory.mainViewModel(didFinish: didFinish))
        }

        internal func bookDetails(bookId: Int, didFinish: @escaping BookDetailsViewModel.FinishCompletion) -> some View {
            return BookDetailsView(viewModel: self.viewModelFactory.bookDetailsViewModel(bookId: bookId, didFinish: didFinish))
        }
    }
}
