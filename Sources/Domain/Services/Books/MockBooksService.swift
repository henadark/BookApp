import Foundation
import Core
import Resources

public final class MockBooksService: BooksServiceProtocol {

    // MARK: Stored Properties

    public var booksByGenre: BooksByGenreDomainModel
    public var topBannerSlides: [TopBannerSlideFirebaseModel]
    public var youWillLikeSection: [Int]

    // MARK: Init

    private init() {

        let remoteConfig = try! JSONDecoder().decode(RemoteConfigFirebaseModel.self, from: "books")
        let builder = BooksByGenreDomainModelBuilder()
        booksByGenre = builder.build(from: remoteConfig.books)
        topBannerSlides = remoteConfig.topBannerSlides
        youWillLikeSection = remoteConfig.youWillLikeSection
    }

    // MARK: BooksServiceProtocol

    public func fetchBooks() async throws {}

    // MARK: Mock

    public class var mock: MockBooksService { MockBooksService() }
}

extension JSONDecoder {

    public func decode<T>(_ type: T.Type, from jsonFileName: String) throws -> T where T : Decodable {

        let bundlePath = Bundle.swiftUIPreviewsCompatibleModule.path(forResource: jsonFileName, ofType: "json")!
        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)!
        return try decode(type, from: jsonData)
    }
}
