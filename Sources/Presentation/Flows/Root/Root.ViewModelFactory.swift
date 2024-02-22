import Foundation
import Helpers
import Domain

extension Root {

    internal final class ViewModelFactory {

        // MARK: Stored Properties

        private let services: ServicesAssemblyProtocol

        // MARK: Init

        internal init(services: ServicesAssemblyProtocol) {
            self.services = services
        }

        // MARK: View Models

        internal func splashViewModel(didFinish: @escaping SplashViewModel.FinishCompletion) -> SplashViewModel {
            return SplashViewModel(
                didFinish: didFinish
            )
        }
    }
}
