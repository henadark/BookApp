import SwiftUI
import UIStyleKit
import AppExtensions
import Helpers

extension Root {

    internal struct SplashView: View {

        // MARK: Stored Properties

        @StateObject public var viewModel: Root.SplashViewModel
        @State private var showErrorMEssage: Bool = false

        // MARK: Body

        internal var body: some View {
            ZStack {
                backgroundView
                VStack(spacing: 12) {
                    Text("Book App")
                        .largeTitle_SecondaryPinkTextStyle()
                    Text("Welcome to Book App")
                        .title_Gray5TextStyle()
                        .lineLimit(1)
                    ProgressSliderView(progress: $viewModel.progress)
                        .padding(.top, AppPadding.x)
                        .padding(.horizontal, 34)
                }
                .padding(.horizontal, AppPadding.x)
                .padding(.bottom, 50)
            }
            .onChange(of: viewModel.errorMessage, { _, newValue in
                showErrorMEssage = !newValue.isEmpty
            })
            .alert("Error", isPresented: $showErrorMEssage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
            .task {
                await viewModel.startLoading()
            }
        }

        // MARK: UI Components

        private var backgroundView: some View {
            Group {
                Image("splashBackground", bundle: Bundle.swiftUIPreviewsCompatibleModule)
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



