//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

struct MarvelAuthentication {
    
    var publicKey = MarvelKey.`public`
    var privateKey = MarvelKey.`private`
    
    var md5: (String) -> String = { str in
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(str, CC_LONG(str.utf8.count), &digest)
        return digest.reduce("") {
            $0 + String(format: "%02x", $1)
        }
    }

    func urlParameters(timestamp: String = MarvelAuthentication.timestamp()) -> String {
        let hash = md5(timestamp + privateKey + publicKey)
        return "&ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    private static func timestamp() -> String {
        return String(Date.init().timeIntervalSinceReferenceDate)
    }
    
}
