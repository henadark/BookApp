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
    }
}
