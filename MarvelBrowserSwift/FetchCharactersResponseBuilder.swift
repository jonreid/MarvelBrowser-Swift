//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import Foundation

private let badJSON = "Bad JSON"

class FetchCharactersResponseBuilder {
    func parse(_ jsonData: Data) -> Result<FetchCharactersResponseModel> {
        let object = try? JSONSerialization.jsonObject(with: jsonData)
        let dict = object as? [String: Any]
        if dict == nil {
            return .failure(badJSON)
        }
        let code = dict?["code"] as? Int
        if code == nil {
            return .failure(badJSON)
        }
        if code == 200 {
            return .success(FetchCharactersResponseModel())
        } else {
            let status = dict?["status"] as? String
            return .failure(status ?? badJSON)
        }
    }
}
