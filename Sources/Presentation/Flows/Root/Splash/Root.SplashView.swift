import SwiftUI
import UIStyleKit
import AppExtensions
import Helpers

extension Root {

    internal struct SplashView: View {

        // MARK: Stored Properties

        @StateObject public var viewModel: Root.SplashViewModel

        // MARK: Body

        internal var body: some View {
            ZStack {
                backgroundView
                VStack(spacing: 12) {
                    Text("Book App")
                        .largeTitle_SecondaryPinkTextStyle()
                    Text("Welcome to Book App")
                        .title_Gray5TextStyle()
                    ProgressSliderView(progress: $viewModel.progress)
                        .padding(.top, 16)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
            .task {
                await viewModel.startLoading()
            }
        }

        // MARK: UI Components

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
    return CommonPreview {
        Root.SplashView(viewModel: viewModel)
    }
}



