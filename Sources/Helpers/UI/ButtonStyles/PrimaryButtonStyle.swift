import SwiftUI
import UIStyleKit

public struct PrimaryButtonStyle: ButtonStyle {

    private let cornerRadius: CGFloat
    private let backgroundColor: Color

    public init(
        cornerRadius: CGFloat = 8,
        backgroundColor: Color = .primaryBlack
    ) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {

        PrimaryButtonStyleView(
            configuration: configuration,
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor
        )
    }
}

private extension PrimaryButtonStyle {

    struct PrimaryButtonStyleView: View {

        // tracks if the button is enabled or not
        @Environment(\.isEnabled) var isEnabled
        // tracks the pressed state
        let configuration: PrimaryButtonStyle.Configuration

        let cornerRadius: CGFloat
        let backgroundColor: Color

        var body: some View {
            return configuration.label
                .foregroundColor(isEnabled ? .primaryWhite : .gray4)
                .background(isEnabled ? backgroundColor : .gray2)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
        }
    }
}
