//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import Foundation

class FetchCharactersResponseBuilder {
    func parse(_ jsonData: Data) -> Result<FetchCharactersResponseModel> {
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData)
        let dict = jsonObject as? [String: Any]
        if dict == nil {
            return .failure("Bad JSON")
        }
        let code = dict?["code"] as? Int
        if code == 200 {
            return .success(FetchCharactersResponseModel())
        } else {
            let status = dict?["status"] as? String
            return .failure(status ?? "")
        }
    }
}
