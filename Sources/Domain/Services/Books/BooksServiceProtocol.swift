import Foundation
import Core

public protocol BooksServiceProtocol {

    func fetchBooks() async throws
}
