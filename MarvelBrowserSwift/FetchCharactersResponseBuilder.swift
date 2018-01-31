//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

struct FetchCharactersResponseBuilder {
    let data: CharactersSliceResponseBuilder?

    init(dictionary dict: [String: Any]) {
        let dataDict = dict["data"] as? [String: Any]
        data = dataDict.map { CharactersSliceResponseBuilder(dictionary: $0) }
    }

    func build() -> FetchCharactersResponseModel {
        return data?.build()
                    .flatMap { .success($0) } ?? .failure("Bad data")
    }
}
