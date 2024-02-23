import SwiftUI
import Helpers
import UIStyleKit

// MARK: - Modifiers

extension View {

    // MARK: Text

    /// font: **Georgia**, size: **52**, weight: **bold**
    public func largeTitle_SecondaryPinkTextStyle() -> some View {
        self.modifier(LargeTitle(color: .secondaryPink))
    }

    /// font: **Nunito Sans**, size: **24**, weight: **bold**
    public func title_Gray4TextStyle() -> some View {
        self.modifier(Title(color: .gray4))
    }

    /// font: **Nunito Sans**, size: **20**, weight: **bold**
    public func title2_PrimaryWhiteTextStyle() -> some View {
        self.modifier(Title2(color: .primaryWhite))
    }

    /// font: **Nunito Sans**, size: **20**, weight: **bold**
    public func title2_PrimaryPinkTextStyle() -> some View {
        self.modifier(Title2(color: .primaryPink))
    }

    /// font: **Nunito Sans**, size: **18**, weight: **bold**
    public func headline_SecondaryBlackTextStyle() -> some View {
        self.modifier(Headline(color: .secondaryBlack))
    }

    /// font: **Nunito Sans**, size: **16**, weight: **semibold**
    public func body_Gray1TextStyle() -> some View {
        self.modifier(BodyText(color: .gray1))
    }

    /// font: **Nunito Sans**, size: **16**, weight: **semibold**
    public func body_Gray5TextStyle() -> some View {
        self.modifier(BodyText(color: .gray5))
    }

    /// font: **Nunito Sans**, size: **14**, weight: **bold**
    public func footnote_Gray4TextStyle() -> some View {
        self.modifier(Footnote(color: .gray4))
    }

    /// font: **Nunito Sans**, size: **14**, weight: **semibold**
    public func footnote2_Gray1TextStyle() -> some View {
        self.modifier(Footnote2(color: .gray1))
    }

    /// font: **Nunito Sans**, size: **12**, weight: **semibold**
    public func caption_Gray3TextStyle() -> some View {
        self.modifier(Caption(color: .gray3))
    }
}
