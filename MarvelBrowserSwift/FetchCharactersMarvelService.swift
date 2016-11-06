//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionProtocol {}

extension URLSession: URLSessionProtocol {}

class FetchCharactersMarvelService {
    init(session: URLSessionProtocol) {
    }

    func fetchCharacters(requestModel: FetchCharactersRequestModel) {
    }
}
