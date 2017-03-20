//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

struct FetchCharactersResponseBuilder {
    let data: CharactersSliceResponseBuilder?

    init(dictionary dict: [String: Any]) {
        let dataDict = dict["data"] as? [String: Any]
        data = dataDict.map() { CharactersSliceResponseBuilder(dictionary: $0) }
    }

    func build() -> FetchCharactersResponseModel {
        return FetchCharactersResponseModel()
    }
}
