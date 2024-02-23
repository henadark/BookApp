import SwiftUI
import Resources

extension Font {

    /// font: **Georgia**, size: **52**, weight: **bold**
    public static let appLargeTitle: Font = Font.georgia(.standart, size: 52, relativeTo: .largeTitle).bold().italic()
    /// font: **Nunito Sans**, size: **24**, weight: **bold**
    public static let appTitle: Font = Font.nunitoSans(.bold, size: 24, relativeTo: .title)
    /// font: **Nunito Sans**, size: **20**, weight: **bold**
    public static let appTitle2: Font = Font.nunitoSans(.bold, size: 20, relativeTo: .title2)
    /// font: **Nunito Sans**, size: **18**, weight: **bold**
    public static let appHeadline: Font = Font.nunitoSans(.bold, size: 18, relativeTo: .headline)
    /// font: **Nunito Sans**, size: **16**, weight: **semibold**
    public static let appBody: Font = Font.nunitoSans(.semibold, size: 16, relativeTo: .body)
    /// font: **Nunito Sans**, size: **14**, weight: **bold**
    public static let appFootnote: Font = Font.nunitoSans(.bold, size: 14, relativeTo: .footnote)
    /// font: **Nunito Sans**, size: **14**, weight: **semibold**
    public static let appFootnote2: Font = Font.nunitoSans(.semibold, size: 14, relativeTo: .footnote)
    /// font: **Nunito Sans**, size: **12**, weight: **semibold**
    public static let appCaption: Font = Font.nunitoSans(.semibold, size: 12, relativeTo: .caption)
}


public enum NunitoSansFontType: String, CaseIterable {

    case bold = "NunitoSans7pt-Bold"
    case semibold = "NunitoSans7pt-SemiBold"
}

public enum GeorgiaFontType: String, CaseIterable {

    case standart = "Georgia"
}

extension Font {

    public static func nunitoSans(
        _ nunitoSans: NunitoSansFontType,
        size: CGFloat,
        relativeTo textStyle: Font.TextStyle
    ) -> Font {
        Font.custom(nunitoSans.rawValue, size: size, relativeTo: textStyle)
    }

    public static func georgia(
        _ nunitoSans: GeorgiaFontType,
        size: CGFloat,
        relativeTo textStyle: Font.TextStyle
    ) -> Font {
        Font.custom(nunitoSans.rawValue, size: size, relativeTo: textStyle)
    }
}

public enum CustomFonts {

    public static func registerFonts() {
        NunitoSansFontType.allCases.forEach {
            registerFont(bundle: Bundle.swiftUIPreviewsCompatibleModule, fontName: $0.rawValue, fontExtension: "ttf")
        }
        GeorgiaFontType.allCases.forEach {
            registerFont(bundle: Bundle.swiftUIPreviewsCompatibleModule, fontName: $0.rawValue, fontExtension: "ttf")
        }
    }

    private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard 
            let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
            let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
            let font = CGFont(fontDataProvider)
        else { fatalError("Couldn't create font from file name: \(fontName).\(fontExtension)") }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
