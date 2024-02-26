import Foundation
import Core

public protocol BooksServiceProtocol {

    func fetchBooks() async throws

    var booksByGenre: BooksByGenreDomainModel { get async }
    var topBannerSlides: [TopBannerSlideFirebaseModel] { get async }
    var youWillLikeSection: [Int] { get async }
}
