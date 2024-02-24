import Foundation

public struct BookFirebaseModel: Decodable {

    // MARK: Stored Properties

    public let id: Int
    public let name: String
    public let author: String
    public let summary: String
    public let genre: String
    public let coverURL: String
    public let views: String
    public let likes: String
    public let quotes: String

    // MARK: Init

    public init(
        id: Int,
        name: String,
        author: String,
        summary: String,
        genre: String,
        coverURL: String,
        views: String,
        likes: String,
        quotes: String
    ) {
        self.id = id
        self.name = name
        self.author = author
        self.summary = summary
        self.genre = genre
        self.coverURL = coverURL
        self.views = views
        self.likes = likes
        self.quotes = quotes
    }

    // MARK: Coding Keys

    private enum CodingKeys: String, CodingKey {
        
        case id, name, author, summary, genre, views, likes, quotes
        case coverURL = "cover_url"
    }
}
