import Foundation

public struct RemoteConfigFirebaseModel: Decodable {

    // MARK: Stored Properties

    public let main: MainBooksFirebaseModel
    public let booksDetails: BooksDetailsFirebaseModel

    // MARK: Init

    public init(
        main: MainBooksFirebaseModel,
        booksDetails: BooksDetailsFirebaseModel
    ) {
        self.main = main
        self.booksDetails = booksDetails
    }

    // MARK: Coding Keys

    private enum CodingKeys: String, CodingKey {

        case main = "json_data"
        case booksDetails = "details_carousel"
    }
}
