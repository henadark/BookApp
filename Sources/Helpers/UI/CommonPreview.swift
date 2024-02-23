import SwiftUI
import UIStyleKit

public struct CommonPreview<Content: View>: View {
    let content: Content

    public init(@ViewBuilder _ content: () -> Content) {
        CustomFonts.registerFonts()
        self.content = content()
    }

    public var body: some View {
        self.content
    }
}
