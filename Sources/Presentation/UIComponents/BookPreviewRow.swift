import SwiftUI
import Kingfisher
import UIStyleKit
import AppExtensions

internal struct BookPreviewRow: View {

    internal let url: URL?
    internal let title: String
    private let imageCorenrRadius: CGFloat = 16

    internal var body: some View {

        VStack(spacing: 0) {
            ImageBannerView(url: url, width: 120, height: 150)
            Text(title)
                .body_Gray6TextStyle()
                .lineLimit(2, reservesSpace: true)
                .frame(maxWidth: 120, alignment: .leading)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ZStack {
        Color.primaryBlack
        BookPreviewRow(
            url: URL(string: "https://unsplash.it/600/300"),
            title: "Title"
        )
        .padding(16)
    }
}
