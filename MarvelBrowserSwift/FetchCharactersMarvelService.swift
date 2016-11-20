//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

struct FetchCharactersMarvelService {
    private let session: URLSessionProtocol
    private let authParametersGenerator: () -> String

    init(session: URLSessionProtocol, authParametersGenerator: @escaping () -> String) {
        self.session = session
        self.authParametersGenerator = authParametersGenerator
    }

    func fetchCharacters(requestModel: FetchCharactersRequestModel) {
        guard let url = makeURL(requestModel: requestModel) else {
            return
        }
        let dataTask = session.dataTask(with: url) { data, response, error in
            print("error: \(error)")
            print("response: \(response)")
            let str = String(data: data ?? Data(), encoding: .utf8)
            print("data: \(str)")
        }
        dataTask.resume()
    }

    private func makeURL(requestModel: FetchCharactersRequestModel) -> URL? {
        guard let namePrefix = requestModel.namePrefix.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return URL(string: "https://gateway.marvel.com/v1/public/characters" +
                "?nameStartsWith=\(namePrefix)" +
                "&limit=\(requestModel.pageSize)" +
                "&offset=\(requestModel.offset)" +
                authParametersGenerator())
    }
}
