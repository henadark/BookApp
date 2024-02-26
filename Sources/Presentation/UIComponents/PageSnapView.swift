import SwiftUI
import UIStyleKit
import Domain

internal struct PageSnapView: View {

    // MARK: Stored Properties

    @Binding internal var currentIndex: Int
    @State private var dragOffset: CGFloat = 0
    @State private var width: CGFloat = 0

    private let peekAmount: CGFloat = -10
    private var dragThreshold: CGFloat { itemWidth / 3 }

    internal let itemWidth: CGFloat
    internal let itemHeight: CGFloat
    internal let maxScaleEffect: CGFloat

    internal let urls: [URL]

    // MARK: Body

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: peekAmount) {
                ForEach(urls.indices, id: \.self) { index in
                    ImageBannerView(
                        url: urls[index],
                        width: itemWidth,
                        height: itemHeight
                    )
                    .scaleEffect(self.scaleValueForItem(at: index, in: geometry))

                }
            }
            .offset(x: calculateOffset() + dragOffset)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { value in
                        withAnimation(.interactiveSpring()) {
                            dragOffset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            finalizePosition(dragValue: value)
                            dragOffset = 0
                        }
                    }
            ).onAppear {
                self.width = geometry.size.width
            }
        }
        .offset(x: (width - itemWidth) / 2)
        .frame(height: itemHeight)
    }

    // MARK: Snap Effect

    private func calculateOffset() -> CGFloat {
        let totalItemWidth = itemWidth + peekAmount
        let baseOffset = -CGFloat(currentIndex) * totalItemWidth
        return baseOffset
    }

    private func scaleValueForItem(at index: Int, in geometry: GeometryProxy) -> CGFloat {

        let currentItemOffset = calculateOffset() + dragOffset

        let itemPosition = CGFloat(index) * (itemWidth + peekAmount) + currentItemOffset
        let offset = (geometry.size.width - itemWidth) / 2
        let distanceFromCenter = abs(geometry.size.width / 2 - itemPosition - itemWidth / 2 - offset)

        let scaleDelta = 1 - maxScaleEffect
        let scale: CGFloat = maxScaleEffect + (scaleDelta * (1 - min(1, distanceFromCenter / (itemWidth + peekAmount))))

        return scale
    }

    private func finalizePosition(dragValue: DragGesture.Value) {

        if dragValue.predictedEndTranslation.width > dragThreshold && currentIndex > 0 {
            currentIndex -= 1
        } else if dragValue.predictedEndTranslation.width < -dragThreshold && currentIndex < urls.count - 1 {
            currentIndex += 1
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PageSnapView(
        currentIndex: .constant(0),
        itemWidth: 200,
        itemHeight: 250,
        maxScaleEffect: 0.8,
        urls: MockBooksService.mock.topBannerSlides.compactMap { $0.urlCover }
    )
}
