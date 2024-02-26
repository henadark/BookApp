import SwiftUI
import Resources

extension Color {

    public static var primaryWhite: Color { Color("Primary White", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var primaryBlack: Color { Color("Primary Black", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var secondaryBlack: Color { Color("Secondary Black", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var tertiaryBlack: Color { Color("Tertiary Black", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var primaryPink: Color { Color("Primary Pink", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var secondaryPink: Color { Color("Secondary Pink", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var primaryViolet: Color { Color("Primary Violet", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var gray1: Color { Color("Gray 1", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var gray2: Color { Color("Gray 2", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var gray3: Color { Color("Gray 3", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var gray4: Color { Color("Gray 4", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var gray5: Color { Color("Gray 5", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var gray6: Color { Color("Gray 6", bundle: Bundle.swiftUIPreviewsCompatibleModule) }

    public static var gray7: Color { Color("Gray 7", bundle: Bundle.swiftUIPreviewsCompatibleModule) }
}

extension ShapeStyle where Self == Color {

    public static var primaryWhite: Color { .primaryWhite }

    public static var primaryBlack: Color { .primaryBlack }

    public static var secondaryBlack: Color { .secondaryBlack }

    public static var tertiaryBlack: Color { .tertiaryBlack }

    public static var primaryPink: Color { .primaryPink }

    public static var secondaryPink: Color { .secondaryPink }

    public static var primaryViolet: Color { .primaryViolet }

    public static var gray1: Color { .gray1 }

    public static var gray2: Color { .gray3 }

    public static var gray3: Color { .gray4 }

    public static var gray4: Color { .gray5 }

    public static var gray5: Color { .gray6 }

    public static var gray6: Color { .gray7 }
}
