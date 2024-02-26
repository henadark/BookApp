import SwiftUI
import UIStyleKit
import Core
import Domain

internal struct BookSection: View {

    internal let title: String
    internal let rowsData: [BookFirebaseModel]
    internal let onRowTap: (Int) -> Void

    internal var body: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    Spacer()
                    LazyHStack(spacing: 8) {
                        ForEach(rowsData) { rowData in
                            BookPreviewRow(url: rowData.imageBookURL, title: rowData.name)
                                .onTapGesture {
                                    onRowTap(rowData.id)
                                }
                        }
                    }
                }
                Spacer()
            }
        } header: {
            BookSectionHeader(title: title)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ZStack {
        Color.primaryBlack
            .ignoresSafeArea()
        BookSection(
            title: "Title",
            rowsData: MockBooksService.mock.booksByGenre[.fantasy]!,
            onRowTap: { _ in }
        )
        .padding(16)
    }
}
