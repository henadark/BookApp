import SwiftUI
import Domain

extension Root {

    internal final class FlowFactory {

        // MARK: Stored Properties

        private let services: ServicesAssemblyProtocol

        // MARK: Init

        internal init(services: ServicesAssemblyProtocol) {
            self.services = services
        }

        // MARK: Flows

        internal func home(startScreen: Home.Flow.Screen, didFinish: @escaping Home.Flow.FinishCompletion) -> some View {
            return Home.Flow(
                startScreen: startScreen,
                viewFactory: Home.ViewFactory(
                    viewModelFactory: Home.ViewModelFactory(services: services)
                ),
                didFinish: didFinish
            )
        }
    }
}
