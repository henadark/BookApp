import SwiftUI
import Helpers
import Domain

extension Root {

    public struct Flow: View {

        private enum Router: String, Hashable, Identifiable {

            case splash
            case home

            var id: String { rawValue }
        }

        // MARK: Stored Properties

        @State private var currentFlow: Router = .splash

        private let flowFactory: FlowFactory
        private let viewFactory: ViewFactory

        // MARK: Init

        internal init(
            flowFactory: FlowFactory,
            viewFactory: ViewFactory
        ) {
            self.flowFactory = flowFactory
            self.viewFactory = viewFactory
        }

        // MARK: Factory

        public static func build() -> Flow {

            let services = ServicesAssembly()
            let flowFactory = FlowFactory(services: services)
            let viewModelFactory = ViewModelFactory(services: services)
            let viewFactory = ViewFactory(viewModelFactory: viewModelFactory)

            return Flow(
                flowFactory: flowFactory,
                viewFactory: viewFactory
            )
        }

        // MARK: View

        public var body: some View {
            content()
        }

        @ViewBuilder private func content() -> some View {
            switch currentFlow {
            case .splash:
                splashView()
            case .home:
                homeFlow()
            }
        }

        private func splashView() -> some View {
            viewFactory.splash {
                withAnimation {
                    currentFlow = .home
                }
            }
        }

        private func homeFlow() -> some View {
            flowFactory.home(startScreen: .main) {}
        }
    }
}
