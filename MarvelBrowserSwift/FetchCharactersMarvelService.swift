//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

struct FetchCharactersMarvelService {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }

    func fetchCharacters(requestModel: FetchCharactersRequestModel) {
        guard let namePrefix = requestModel.namePrefix.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters" +
                "?nameStartsWith=\(namePrefix)" +
                "&limit=\(requestModel.pageSize)") else {
            return
        }
        _ = self.session.dataTask(with: url) { data, response, error in  }
    }
}
