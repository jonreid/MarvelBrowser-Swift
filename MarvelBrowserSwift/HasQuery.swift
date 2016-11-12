import Foundation

extension URL {

    func hasQuery(name: String, value: String) -> Bool {
        let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        let matchingQuery = queryItems.filter{ $0.name == name && $0.value == value }.first
        return matchingQuery != nil
    }

}
