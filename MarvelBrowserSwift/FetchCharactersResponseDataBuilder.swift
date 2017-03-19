//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

class FetchCharactersResponseDataBuilder {
    var offset: Int?
    var total: Int?
    var results: [CharacterResponseBuilder]?

    func parse(dictionary dict: [String: Any]) {
        offset = dict["offset"] as? Int
        total = dict["total"] as? Int
        if let resultsArray = dict["results"] as? Array<[String: Any]> {
            parseResults(from: resultsArray)
        }
    }

    private func parseResults(from array: Array<[String: Any]>) {
        var accumulator: [CharacterResponseBuilder] = []
        for dict in array {
            let builder = CharacterResponseBuilder()
            builder.parse(dictionary: dict)
            accumulator.append(builder)
        }
        results = accumulator
    }
}
