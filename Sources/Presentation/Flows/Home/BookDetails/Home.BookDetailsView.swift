import SwiftUI
import UIStyleKit
import AppExtensions
import Helpers
import Domain

extension Home {

    internal struct BookDetailsView: View {

        // MARK: Stored Properties
        
        @StateObject public var viewModel: BookDetailsViewModel

        // MARK: Body

        internal var body: some View {
            VStack {
                Text("")
            }
            .navigationBarBackButtonHidden(true)
            .toolbar { backButton }
        }

        // MARK: UI Components

        private var backButton: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: viewModel.onBackButtonTap) {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

#Preview {

    let viewModel = Home.BookDetailsViewModel.mock
    return NavigationStack {
        CommonPreview {
            Home.BookDetailsView(viewModel: viewModel)
        }
    }
}
