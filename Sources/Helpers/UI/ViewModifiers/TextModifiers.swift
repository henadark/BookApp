import SwiftUI
import UIStyleKit

/// font: **Georgia**, size: **52**, weight: **bold**
public struct LargeTitle: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appLargeTitle)
            .foregroundColor(color)
    }
}

/// font: **Nunito Sans**, size: **24**, weight: **bold**
public struct Title: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appTitle)
            .foregroundColor(color)
    }
}

/// font: **Nunito Sans**, size: **20**, weight: **bold**
public struct Title2: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appTitle2)
            .foregroundColor(color)
    }
}

/// font: **Nunito Sans**, size: **18**, weight: **bold**
public struct Headline: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appHeadline)
            .foregroundColor(color)
    }
}

/// font: **Nunito Sans**, size: **16**, weight: **semibold**
public struct BodyText: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appBody)
            .foregroundColor(color)
    }
}

/// font: **Nunito Sans**, size: **14**, weight: **bold**
public struct Footnote: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appFootnote)
            .foregroundColor(color)
    }
}

/// font: **Nunito Sans**, size: **14**, weight: **semibold**
public struct Footnote2: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appFootnote2)
            .foregroundColor(color)
    }
}

/// font: **Nunito Sans**, size: **12**, weight: **semibold**
public struct Caption: ViewModifier {

    private let color: Color

    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .font(.appCaption)
            .foregroundColor(color)
    }
}
