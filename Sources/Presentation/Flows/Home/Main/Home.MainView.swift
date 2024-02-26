import SwiftUI
import UIStyleKit
import AppExtensions
import Helpers
import Domain

extension Home {

    internal struct MainView: View {

        // MARK: Stored Properties

        @StateObject public var viewModel: MainViewModel

        // MARK: Body

        internal var body: some View {
            ZStack {
                Color.primaryBlack
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    navigationTitle
                    scrollViewContent
                }
            }
        }

        // MARK: UI Components

        private var navigationTitle: some View {
            Text("Library")
                .title2_PrimaryPinkTextStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, AppPadding.x)
                .padding(.bottom, AppPadding.xs)
        }

        private var scrollViewContent: some View {
            ScrollView {
                VStack(spacing: 20) {
                    topBanner

                    if let books = viewModel.booksByGenre {
                        LazyVStack(alignment: .center, spacing: AppPadding.x) {
                            ForEach(viewModel.genres) { genreType in
                                if let books = books[genreType] {
                                    BookSection(
                                        title: genreType.rawValue,
                                        rowsData: books,
                                        sectionTitleColor: .primaryWhite,
                                        rowTitleColor: .gray6,
                                        onRowTap: viewModel.onBookTap(bookId:)
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }

        private var topBanner: some View {
            GeometryReader { proxy in
                PageSliderView(
                    collection: viewModel.topBannerSlides,
                    autoScroll: viewModel.autoScrollBannerTimeInterval,
                    pageIndicatorTintColor: .gray5,
                    currentPageIndicatorTintColor: .primaryPink
                ) { rowData in
                    ImageBannerView(
                        url: rowData.urlCover,
                        width: proxy.size.width - 32,
                        height: 160
                    )
                    .onTapGesture {
                        viewModel.onBannerTap(bookId: rowData.bookID)
                    }
                }
            }
            .frame(height: 160)
            .padding(.vertical, 20)
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
