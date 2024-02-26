import SwiftUI
import UIStyleKit
import Core
import Domain

internal struct BookSection: View {

    internal let title: String
    internal let rowsData: [BookFirebaseModel]
    internal let sectionTitleColor: Color
    internal let rowTitleColor: Color
    internal let onRowTap: (Int) -> Void

    internal var body: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: AppPadding.xs) {
                    Spacer()
                    LazyHStack(spacing: AppPadding.xs) {
                        ForEach(rowsData) { rowData in
                            BookPreviewRow(url: rowData.imageBookURL, title: rowData.name, titleColor: rowTitleColor)
                                .onTapGesture {
                                    onRowTap(rowData.id)
                                }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        } header: {
            BookSectionHeader(title: title, titleColor: sectionTitleColor)
                .padding(.horizontal, AppPadding.x)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ZStack {
        Color.primaryBlack
            .ignoresSafeArea()
        BookSection(
            title: "Title",
            rowsData: MockBooksService.mock.booksByGenre[.fantasy]!,
            sectionTitleColor: .primaryWhite,
            rowTitleColor: .gray6,
            onRowTap: { _ in }
        )
        .padding(AppPadding.x)
    }
}
