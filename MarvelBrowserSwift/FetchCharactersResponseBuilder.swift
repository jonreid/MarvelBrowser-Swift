//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

struct FetchCharactersResponseBuilder {
    let data: CharactersSliceResponseBuilder?

    init(dictionary dict: [String: Any]) {
        if let dataDict = dict["data"] as? [String: Any] {
            data = CharactersSliceResponseBuilder(dictionary: dataDict)
        } else {
            data = nil
        }
    }
}
