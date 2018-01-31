//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

enum Result<T> {
    case success(T)
    case failure(String)
}

typealias FetchCharactersResponseModel = Result<CharactersSliceResponseModel>
