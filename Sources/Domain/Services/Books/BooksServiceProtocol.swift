import Foundation
import Core

public protocol BooksServiceProtocol {

    func fetchBooks() async throws

    var booksByGenre: BooksByGenreDomainModel { get async }
    var topBannerSlides: [TopBannerSlideFirebaseModel] { get async }
    var youWillLikeSection: [BookFirebaseModel] { get async }
    var booksDetails: [BookFirebaseModel] { get async }
}
