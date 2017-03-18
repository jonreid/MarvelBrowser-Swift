//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

class CharacterResponseBuilder {
    var name: String?

    func parse(dictionary dict: [String: Any]) {
        name = dict["name"] as? String
    }

    func build() -> CharacterResponse {
        return CharacterResponse()
    }
}
