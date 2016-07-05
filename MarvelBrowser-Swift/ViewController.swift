//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Concatenate keys per https://developer.marvel.com/documentation/authorization
        let timeStamp = "1" // Hard-coded for spike
        let keys = timeStamp + MarvelKeys.privateKey + MarvelKeys.publicKey

        // Confirm manually:
        print(keys)

        // Create MD5 hash:
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(keys, CC_LONG(keys.utf8.count), &digest)
        var hash = ""
        for (_, byte) in digest.enumerated() {
            hash += String(format: "%02x", byte)
        }

        // Manually confirm that it's 32 hex digits:
        print(hash)

        // Manually confirm URL string:
        let urlString = "https://gateway.marvel.com/v1/public/characters?nameStartsWith=Spider&ts=\(timeStamp)&apikey=\(MarvelKeys.publicKey)&hash=\(hash)"
        print(urlString)
        
        // Create data task:
        let session = URLSession.shared()
        let url = URL(string: urlString)!
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            print("error: ", error);
            print("response: ", response);
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print("data: ", str);
        }
        dataTask.resume()
    }
}
