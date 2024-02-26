import Foundation

public struct BooksDetailsFirebaseModel: Decodable {

    // MARK: Stored Properties

    public let items: [BookFirebaseModel]

    // MARK: Init

    public init(items: [BookFirebaseModel]) {
        self.items = items
    }

    // MARK: Coding Keys

    private enum CodingKeys: String, CodingKey {

        case items = "books"
    }
}
