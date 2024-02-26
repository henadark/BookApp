import SwiftUI
import Resources
import UIStyleKit
import AppExtensions
import Core
import Domain

internal struct BookInfoHStack: View {

    // MARK: Stored Properies

    internal var book: BookFirebaseModel

    // MARK: Body

    internal var body: some View {
        HStack(spacing: AppPadding.l) {

            infoView(title: book.views, subtitle: "Readers")
            infoView(title: book.likes, subtitle: "Likes")
            infoView(title: book.quotes, subtitle: "Quotes")
            infoView(title: book.genre.rawValue, subtitle: "Genre", imageName: "hot")
        }
    }

    // MARK: UI Components

    @ViewBuilder
    func infoView(title: String, subtitle: String, imageName: String? = nil) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                Text(title)
                    .headline_SecondaryBlackTextStyle()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                if let name = imageName {
                    Image(name, bundle: Bundle.swiftUIPreviewsCompatibleModule)
                }
            }
            Text(subtitle)
                .caption_Gray4TextStyle()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {

    BookInfoHStack(book: MockBooksService.mock.booksDetails[0])
        .padding(AppPadding.x)
        .frame(height: 80)
}
