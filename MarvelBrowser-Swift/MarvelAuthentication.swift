//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

struct MarvelAuthentication {
    
    func timestamp() -> String {
        return String(Date.init().timeIntervalSinceReferenceDate)
    }
    
}
