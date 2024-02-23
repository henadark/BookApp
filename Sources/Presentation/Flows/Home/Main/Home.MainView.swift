import SwiftUI
import UIStyleKit
import AppExtensions
import Helpers

extension Home {

    internal struct MainView: View {

        @StateObject public var viewModel: MainViewModel

        internal var body: some View {

            VStack {
                Text("Hello")
            }
            .navigationTitle("View")
        }
    }
}

#Preview {

    let viewModel = Home.MainViewModel.mock
    return NavigationStack {
        CommonPreview {
            Home.MainView(viewModel: viewModel)
        }
    }
}

