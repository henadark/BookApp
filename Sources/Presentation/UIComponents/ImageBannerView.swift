import SwiftUI
import UIStyleKit
import Kingfisher

internal struct ImageBannerView: View {

    internal let url: URL?
    internal let width: CGFloat
    internal let height: CGFloat
    private let imageCorenrRadius: CGFloat = AppCornerRadius.medium

    internal var body: some View {
        KFImage(url)
            .cacheOriginalImage()
            .placeholder { progress in
                RoundedRectangle(cornerRadius: imageCorenrRadius)
                    .foregroundStyle(.gray2)
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: imageCorenrRadius, style: .continuous))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ImageBannerView(
        url: URL(string: "https://unsplash.it/600/300"),
        width: 350,
        height: 160
    )
    .padding(AppPadding.x)
}
