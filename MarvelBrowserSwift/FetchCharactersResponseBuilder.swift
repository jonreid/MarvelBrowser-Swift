//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

struct FetchCharactersResponseBuilder {
    let data: CharactersSliceResponseBuilder?

    init(dictionary: [String: Any]) {
        data = nil
    }
}
