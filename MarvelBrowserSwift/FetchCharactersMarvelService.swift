//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
}

class FetchCharactersMarvelService {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }

    func fetchCharacters(requestModel: FetchCharactersRequestModel) {
        guard let url = URL(string: "http://gateway.marvel.com") else { return }
//        _ = self.session.dataTask(with: url) { data, response, error in  }
    }
}
