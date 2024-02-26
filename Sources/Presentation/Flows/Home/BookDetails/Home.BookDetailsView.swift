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
            VStack(spacing: 0) {

                topView

                ScrollView(showsIndicators: false, content: scrollViewContent)
                    .scrollContentBackground(.hidden)
                    .background {
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: AppCornerRadius.big,
                                bottomLeading: 0.0,
                                bottomTrailing: 0.0,
                                topTrailing: AppCornerRadius.big
                            ),
                            style: .continuous
                        )
                        .foregroundStyle(.primaryWhite)
                        .ignoresSafeArea()
                    }
                    .offset(y: -22)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar { backButton }
        }

        // MARK: UI Components

        private var backButton: some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: viewModel.onBackButtonTap) {
                    Image("backButton", bundle: Bundle.swiftUIPreviewsCompatibleModule)
                }
            }
        }

        private var topView: some View {
            ZStack {
                    Color.primaryViolet
                        .ignoresSafeArea()
                    Image("detailsBackground", bundle: Bundle.swiftUIPreviewsCompatibleModule)
                        .resizable()
                        .opacity(0.6)
                        .ignoresSafeArea()
                    Color.tertiaryBlack.ignoresSafeArea()
                VStack(spacing: AppPadding.x) {
                    PageSnapView(
                        currentIndex: $viewModel.currentSelectedIndex,
                        itemWidth: 200,
                        itemHeight: 250,
                        maxScaleEffect: 0.8,
                        urls: viewModel.books.compactMap { $0.imageBookURL }
                    )
                    VStack(spacing: 4) {
                            Group {
                                Text(viewModel.currentBookName)
                                    .title2_PrimaryWhiteTextStyle()
                                Text(viewModel.currentAuthorName)
                                    .footnote_Gray5TextStyle()
                            }
                            .lineLimit(1)
                    }
                    .padding(.horizontal, AppPadding.x)
                    .padding(.bottom, AppPadding.l)
                }
            }
        }

        private func scrollViewContent() -> some View {
            VStack(spacing: AppPadding.x) {
                selectedBookInfoSection

                BookSection(
                    title: "You will also like",
                    rowsData: viewModel.youWillLikeSection,
                    sectionTitleColor: .secondaryBlack,
                    rowTitleColor: .gray1,
                    onRowTap: { _ in }
                )

                PrimaryButton(title: "Read Now", action: viewModel.onReadNowButtonTap)
                    .padding(.top, 8)
            }
        }

        private var selectedBookInfoSection: some View {
            Group {
                if let book = viewModel.currentBook {
                    VStack(spacing: AppPadding.x) {
                        VStack(spacing: 10) {
                            Spacer()
                            BookInfoHStack(book: book)
                            Divider()
                        }
                        VStack(spacing: AppPadding.xs) {
                            Text("Summary")
                                .title2_SecondaryBlackTextStyle()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(book.summary)
                                .footnote2_Gray1TextStyle()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                    .padding(.horizontal, AppPadding.x)
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
