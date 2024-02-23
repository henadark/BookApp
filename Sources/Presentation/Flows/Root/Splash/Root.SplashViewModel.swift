import SwiftUI
import Domain
import Helpers

extension Root {

    internal final class SplashViewModel: ObservableObject {

        internal typealias FinishCompletion = VoidCompletion

        // MARK: Stored Properties

        // Domain
        internal let didFinish: FinishCompletion

        // Helpers
        private let downloadTimeInterval = 2_000
        private var elapsedTimeInterval: Double = 0
        private let timeStep = 100

        // UI
        @Published internal var progress: Double = 0

        // MARK: Init

        internal init(
            didFinish: @escaping FinishCompletion
        ) {
            self.didFinish = didFinish
        }

        // MARK: Actions

        @MainActor
        internal func startLoading() async {
            for _ in 1 ... downloadTimeInterval / timeStep {
                try? await Task.sleep(until: .now.advanced(by: .milliseconds(timeStep)), clock: .continuous)
                elapsedTimeInterval += Double(timeStep)
                let newProgress = elapsedTimeInterval / Double(downloadTimeInterval)
                withAnimation {
                    progress = newProgress
                }
            }
        }

        // MARK: Mock

        internal class var mock: SplashViewModel{
            SplashViewModel(
                didFinish: {}
            )
        }
    }
}
