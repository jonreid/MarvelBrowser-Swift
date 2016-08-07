//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

struct MarvelAuthentication {
    
    var publicKey = MarvelKey.`public`
    var privateKey = MarvelKey.`private`
    
    var timestampClosure = {
        return String(Date.init().timeIntervalSinceReferenceDate)
    }
    
    var timestamp: String {
        return timestampClosure()
    }
    
    func md5(_ string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(string, CC_LONG(string.utf8.count), &digest)
        return digest.reduce("") {
            $0 + String(format: "%02x", $1)
        }
    }
    
}
