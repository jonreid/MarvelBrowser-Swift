//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

struct CharacterResponseBuilder {
    let name: String?

    init(dictionary dict: [String: Any]) {
        name = dict["name"] as? String
    }

    func build() -> CharacterResponse? {
        guard let name = name else {
            return nil
        }
        return CharacterResponse(name: name)
    }
}
