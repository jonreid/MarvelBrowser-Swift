//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import Foundation

private let badJSON = "Bad JSON"

func parseFetchCharacters(jsonData: Data) -> FetchCharactersResponseModel {
    let object = try? JSONSerialization.jsonObject(with: jsonData)
    guard let dict = object as? [String: Any],
          let code = dict["code"] as? Int else {
        return .failure(badJSON)
    }
    if code != 200 {
        return .failure(dict["status"] as? String ?? badJSON)
    }
    let builder = FetchCharactersResponseBuilder(dictionary: dict)
    return builder.build()
}
