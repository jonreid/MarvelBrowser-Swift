//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

class FetchCharactersResponseDataBuilder {
    var offset: Int?
    var total: Int?
    var results: [CharacterResponseBuilder]?

    func parse(dictionary dict: [String: Any]) {
        offset = dict["offset"] as? Int
        total = dict["total"] as? Int
        if let r = dict["results"] as? Array<[String: Any]> {
            var accumulator: [CharacterResponseBuilder] = []
            for resultsDict in r {
                let builder = CharacterResponseBuilder()
                builder.parse(dictionary: resultsDict)
                accumulator.append(builder)
            }
            results = accumulator
        }
    }
}
