//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import Foundation

extension URL {

    func hasQuery(name: String, value: String) -> Bool {
        let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        let matchingQueries = queryItems.filter { $0.name == name && $0.value == value }
        return !matchingQueries.isEmpty
    }

}
