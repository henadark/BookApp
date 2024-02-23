import SwiftUI
import UIStyleKit
import AppExtensions

extension Root {

    internal struct SplashView: View {

        @StateObject public var viewModel: Root.SplashViewModel

        internal var body: some View {
            ZStack {
                backgroundView
                VStack(spacing: 12) {
                    Text("Book App")
                        .largeTitle_SecondaryPinkTextStyle()
                }
            }
        }

        private var backgroundView: some View {
            Group {
                Image("background", bundle: Bundle.swiftUIPreviewsCompatibleModule)
                    .resizable()
                Image("heart", bundle: Bundle.swiftUIPreviewsCompatibleModule)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {

    let viewModel = Root.SplashViewModel.mock
    return Root.SplashView(viewModel: viewModel)
}



