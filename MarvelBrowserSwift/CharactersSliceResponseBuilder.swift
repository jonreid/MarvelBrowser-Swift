//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

struct CharactersSliceResponseBuilder {
    let offset: Int?
    let total: Int?
    let results: [CharacterResponseBuilder]?

    init(dictionary dict: [String: Any]) {
        offset = dict["offset"] as? Int
        total = dict["total"] as? Int
        results = type(of: self).parseResults(from: dict["results"] as? Array<Any>)
    }

    private static func parseResults(from array: Array<Any>?) -> [CharacterResponseBuilder]? {
        guard let array = array else {
            return nil
        }
        var result: [CharacterResponseBuilder] = []
        for obj in array {
            if let dict = obj as? [String: Any] {
                result.append(CharacterResponseBuilder(dictionary: dict))
            }
        }
        return result
    }

    func build() -> CharactersSliceResponseModel? {
        guard let offset = offset,
              let total = total else {
            return nil
        }
        return CharactersSliceResponseModel(offset: offset, total: total, characters: buildCharacters())
    }

    private func buildCharacters() -> [CharacterResponseModel] {
        return results?.flatMap { $0.build() } ?? []
    }
}
