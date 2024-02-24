import Foundation
import Core

public final class MockBooksService: BooksServiceProtocol {

    // MARK: Init

    public init() {}

    // MARK: BooksServiceProtocol

    public func fetchBooks() async throws {}
}
