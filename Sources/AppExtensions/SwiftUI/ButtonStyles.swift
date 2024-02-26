import SwiftUI
import UIStyleKit
import Helpers

extension ButtonStyle where Self == PrimaryButtonStyle {

    public static func primary(
        cornerRadius: CGFloat = 30,
        backgroundColor: Color = .secondaryPink
    ) -> PrimaryButtonStyle {
        PrimaryButtonStyle(cornerRadius: cornerRadius, backgroundColor: backgroundColor)
    }
}
