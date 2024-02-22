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
    }
}
