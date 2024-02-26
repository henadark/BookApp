import Foundation

public enum BookGenreFirebaseModel: String, CaseIterable, Identifiable, Decodable {

    case fantasy = "Fantasy"
    case science = "Science"
    case romance = "Romance"

    public var id: String { rawValue }
}
