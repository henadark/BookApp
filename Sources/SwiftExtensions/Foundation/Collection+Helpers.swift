import Foundation

extension Collection {

    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    public var isNotEmpty: Bool { !isEmpty }
}

extension Collection where Element == String? {

    public func compactJoined(withSeperator separator: String) -> String? {

        let line = self.compactMap { $0 }.joined(separator: separator)
        return line.isNotEmpty ? line : nil
    }
}

extension Collection where Element == URLQueryItem {

    public func toDictionary() -> [String: String] {

        var dictionary: [String: String] = [:]
        for item in self {
            if let value = item.value {
                dictionary[item.name] = value
            }
        }
        return dictionary
    }
}
