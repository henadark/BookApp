import SwiftUI
import Resources

extension Font {

    /// font: **Georgia**, size: **52**, weight: **bold**
    public static let appLargeTitle: Font = Font.custom("Georgia", size: 52, relativeTo: .largeTitle).bold().italic()
    /// font: **Nunito Sans**, size: **24**, weight: **bold**
    public static let appTitle: Font = Font.custom("NunitoSans", size: 24, relativeTo: .title).bold()
    /// font: **Nunito Sans**, size: **20**, weight: **bold**
    public static let appTitle2: Font = Font.custom("NunitoSans", size: 20, relativeTo: .title2).bold()
    /// font: **Nunito Sans**, size: **18**, weight: **bold**
    public static let appHeadline: Font = Font.custom("NunitoSans", size: 18, relativeTo: .headline).bold()
    /// font: **Nunito Sans**, size: **16**, weight: **semibold**
    public static let appBody: Font = Font.custom("NunitoSans", size: 16, relativeTo: .body).weight(.semibold)
    /// font: **Nunito Sans**, size: **14**, weight: **bold**
    public static let appFootnote: Font = Font.custom("NunitoSans", size: 14, relativeTo: .footnote).bold()
    /// font: **Nunito Sans**, size: **14**, weight: **semibold**
    public static let appFootnote2: Font = Font.custom("NunitoSans", size: 14, relativeTo: .footnote).weight(.semibold)
    /// font: **Nunito Sans**, size: **12**, weight: **semibold**
    public static let appCaption: Font = Font.custom("NunitoSans", size: 12, relativeTo: .caption).weight(.semibold)
}
