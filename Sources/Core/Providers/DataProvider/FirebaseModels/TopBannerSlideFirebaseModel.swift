import Foundation

public struct TopBannerSlideFirebaseModel: Decodable, Identifiable {

    // MARK: Stored Properties

    public let id: Int
    public let bookID: Int
    public let cover: String

    // MARK: Init

    public init(id: Int, bookID: Int, cover: String) {
        self.id = id
        self.bookID = bookID
        self.cover = cover
    }

    // MARK: Helpers

    public var urlCover: URL? { URL(string: cover) }

    // MARK: Coding Keys

    private enum CodingKeys: String, CodingKey {
        
        case id, cover
        case bookID = "book_id"
    }
}
