//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

struct MarvelAuthentication {
    
    var publicKey = MarvelKey.`public`
    var privateKey = MarvelKey.`private`
    
    var timestampClosure = {
        return String(Date.init().timeIntervalSinceReferenceDate)
    }

    var md5Closure: (String) -> String = { str in
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(str, CC_LONG(str.utf8.count), &digest)
        return digest.reduce("") {
            $0 + String(format: "%02x", $1)
        }
    }

    var timestamp: String {
        return timestampClosure()
    }
    
    func md5(_ string: String) -> String {
        return md5Closure(string)
    }
    
    var urlParameters: String {
        let ts = timestamp
        let apikey = publicKey
        let hash = md5(timestamp + privateKey + publicKey)
        return "&ts=\(ts)&apikey=\(apikey)&hash=\(hash)"
    }
    
}
