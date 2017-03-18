//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

class FetchCharactersResponseDataBuilder {
    var offset: NSNumber?

    func parse(dictionary dict: [String: Any]) {
        offset = dict["offset"] as? NSNumber
    }
}
