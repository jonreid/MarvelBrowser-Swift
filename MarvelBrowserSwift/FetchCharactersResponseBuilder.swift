//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

class FetchCharactersResponseBuilder {
    func parse(jsonData: Data) -> FetchCharactersResponseModel {
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData)
        let dict = jsonObject as? [String: Any]
        let code = dict?["code"] as? Int
        return FetchCharactersResponseModel(code: code)
    }
}
