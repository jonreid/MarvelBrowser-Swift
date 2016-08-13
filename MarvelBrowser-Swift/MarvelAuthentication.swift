//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import Foundation

func md5(_ str: String) -> String {
    var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5(str, CC_LONG(str.utf8.count), &digest)
    return digest.reduce("") {
        $0 + String(format: "%02x", $1)
    }
}

struct MarvelAuthentication {

    var publicKey = MarvelKey.`public`
    var privateKey = MarvelKey.`private`

    func urlParameters(
            timestamp: String = MarvelAuthentication.timestamp(),
            md5: (String) -> String = md5)
                    -> String {
        let hash = md5(timestamp + privateKey + publicKey)
        return "&ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
    }

    private static func timestamp() -> String {
        return String(Date.init().timeIntervalSinceReferenceDate)
    }

}
