//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

enum Result<T> {
    case success(T)
    case failure(String)
}

struct FetchCharactersResponseModel {
    let offset: Int
    let total: Int
    let characters: [CharacterResponse]
}
