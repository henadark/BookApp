import Foundation

public protocol DataProviderProtocol {
 
    func fetchBooks() async throws -> RemoteConfigFirebaseModel
}
