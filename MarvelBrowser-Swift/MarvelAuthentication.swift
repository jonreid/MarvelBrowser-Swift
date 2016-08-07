//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

struct MarvelAuthentication {
    
    var timestamp: String {
        return String(Date.init().timeIntervalSinceReferenceDate)
    }
    
    var publicKey: String {
        return MarvelKey.`public`
    }
    
    var privateKey: String {
        return MarvelKey.`private`
    }
    
    func calculateMd5(_ string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(string, CC_LONG(string.utf8.count), &digest)
        return digest.reduce("") {
            $0 + String(format: "%02x", $1)
        }
    }
    
}
