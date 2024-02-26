import SwiftUI
import Kingfisher
import UIStyleKit
import AppExtensions

internal struct BookPreviewRow: View {

    internal let url: URL?
    internal let title: String
    internal let titleColor: Color
    private let imageCorenrRadius: CGFloat = AppCornerRadius.medium

    internal var body: some View {

        VStack(spacing: 0) {
            ImageBannerView(url: url, width: 120, height: 150)
            Text(title)
                .font(.appBody)
                .foregroundStyle(titleColor)
                .lineLimit(2, reservesSpace: true)
                .frame(maxWidth: 120, alignment: .leading)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BookPreviewRow(
        url: URL(string: "https://unsplash.it/600/300"),
        title: "Title",
        titleColor: .gray6
    )
    .padding(AppPadding.x)
    .background(Color.primaryBlack)
}
