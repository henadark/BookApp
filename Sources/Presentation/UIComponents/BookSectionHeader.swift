import SwiftUI
import UIStyleKit

internal struct BookSectionHeader: View {

    internal let title: String
    internal let titleColor: Color

    internal var body: some View {
        Text(title)
            .font(.appTitle2)
            .foregroundStyle(titleColor)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BookSectionHeader(title: "Title", titleColor: .primaryWhite)
        .padding(AppPadding.x)
        .background(Color.primaryBlack)
}
