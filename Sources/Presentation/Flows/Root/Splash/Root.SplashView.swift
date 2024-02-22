import SwiftUI
import UIStyleKit

extension Root {

    internal struct SplashView: View {

        @StateObject public var viewModel: Root.SplashViewModel

        internal var body: some View {

            VStack {
                Text("Hello")
            }
        }
    }
}

#Preview {

    let viewModel = Root.SplashViewModel.mock
    return Root.SplashView(viewModel: viewModel)
}



