import SwiftUI
import UIStyleKit

public struct ProgressSliderView: View {

    // MARK: Stored Properties

    @Binding private var progress: Double
    private let height: CGFloat
    private let backgroundColor: Color
    private let progressColor: Color
    @State private var containerWidth: CGFloat = 0

    private var maxWidth: Double { min(progress * containerWidth, containerWidth) }

    // MARK: Ini

    public init(
        progress: Binding<Double>,
        height: CGFloat = 6,
        backgroundColor: Color = .gray6,
        progressColor: Color = .primaryWhite
    ) {
        self._progress = progress
        self.height = height
        self.backgroundColor = backgroundColor
        self.progressColor = progressColor
    }

    // MARK: View

    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 60)
                    .foregroundColor(backgroundColor)
                    .onAppear {
                        containerWidth = proxy.size.width
                    }
                RoundedRectangle(cornerRadius: 60)
                    .foregroundColor(progressColor)
                    .frame(width: maxWidth)
            }
        }
        .frame(height: height)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ProgressSliderView(progress: .constant(0.4))
        .padding()
        .background(.black)
}
