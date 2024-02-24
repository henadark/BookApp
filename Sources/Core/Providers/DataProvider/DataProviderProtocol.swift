import Foundation

public protocol DataProviderProtocol: Actor {
 
    func fetchBooks() async throws -> RemoteConfigFirebaseModel
}
