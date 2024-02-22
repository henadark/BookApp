import SwiftUI

extension Root {

    internal final class ViewFactory {

        // MARK: Stored Properties

        private let viewModelFactory: ViewModelFactory

        // MARK: Init

        internal init(viewModelFactory: ViewModelFactory) {
            self.viewModelFactory = viewModelFactory
        }

        // MARK: Views

        internal func splash(didFinish: @escaping SplashViewModel.FinishCompletion) -> some View {
            return SplashView(viewModel: self.viewModelFactory.splashViewModel(didFinish: didFinish))
        }
    }
}
