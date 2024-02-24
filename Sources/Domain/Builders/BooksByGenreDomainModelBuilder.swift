import Foundation
import Core

internal struct BooksByGenreDomainModelBuilder {

    internal func build(from books: [BookFirebaseModel]) -> BooksByGenreDomainModel {

        var booksByGenre: [BookGenreFirebaseModel: [BookFirebaseModel]] = [:]

        BookGenreFirebaseModel.allCases.forEach { genre in
            let array = books.filter { $0.genre == genre }
            booksByGenre[genre] = array
        }

        return booksByGenre
    }
}
