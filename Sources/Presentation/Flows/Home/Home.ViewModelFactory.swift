import Foundation
import Domain

extension Home {

    internal final class ViewModelFactory {

        // MARK: Stored Properties

        private let services: ServicesAssemblyProtocol

        // MARK: Init

        internal init(services: ServicesAssemblyProtocol) {
            self.services = services
        }

        // MARK: View Models

        internal func mainViewModel(didFinish: @escaping MainViewModel.FinishCompletion) -> MainViewModel {
            return MainViewModel(
                booksService: services.booksService,
                didFinish: didFinish
            )
        }

        internal func bookDetailsViewModel(didFinish: @escaping BookDetailsViewModel.FinishCompletion) -> BookDetailsViewModel {
            return BookDetailsViewModel(
                booksService: services.booksService,
                didFinish: didFinish
            )
        }
    }
}
