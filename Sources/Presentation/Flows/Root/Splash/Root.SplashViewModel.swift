import Foundation
import Combine
import Domain
import Helpers

extension Root {

    internal final class SplashViewModel: ObservableObject {

        internal typealias FinishCompletion = VoidCompletion

        // MARK: Stored Properties

        // Domain
        internal let didFinish: FinishCompletion

        // Helpers
        private var cancellableSet = Set<AnyCancellable>()

        // MARK: Init

        internal init(
            didFinish: @escaping FinishCompletion
        ) {
            self.didFinish = didFinish
        }

        deinit {
            cancellableSet.forEach { $0.cancel() }
        }

        // MARK: Actions

        internal func onViewDidLoad() {
        }

        internal func onAppear() {}

        internal func onDisappear() {}

        // MARK: Mock

        internal class var mock: SplashViewModel{
            SplashViewModel(
                didFinish: {}
            )
        }
    }
}
