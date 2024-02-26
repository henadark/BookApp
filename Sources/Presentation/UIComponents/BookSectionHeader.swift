import SwiftUI
import UIStyleKit

internal struct BookSectionHeader: View {

    internal let title: String

    internal var body: some View {
        Text(title)
            .title2_PrimaryWhiteTextStyle()
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ZStack {
        Color.primaryBlack
        BookSectionHeader(title: "Title")
        .padding(16)
    }
    .frame(height: 60)
}
