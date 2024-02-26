import Foundation

public struct MainBooksFirebaseModel: Decodable {

    // MARK: Stored Properties

    public let books: [BookFirebaseModel]
    public let topBannerSlides: [TopBannerSlideFirebaseModel]
    public let youWillLikeSection: [Int]

    // MARK: Init

    public init(
        books: [BookFirebaseModel],
        topBannerSlides: [TopBannerSlideFirebaseModel],
        youWillLikeSection: [Int]
    ) {
        self.books = books
        self.topBannerSlides = topBannerSlides
        self.youWillLikeSection = youWillLikeSection
    }

    // MARK: Coding Keys

    private enum CodingKeys: String, CodingKey {

        case books
        case topBannerSlides = "top_banner_slides"
        case youWillLikeSection = "you_will_like_section"
    }
}
