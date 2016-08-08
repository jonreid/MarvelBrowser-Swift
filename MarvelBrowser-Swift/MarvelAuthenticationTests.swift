//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowser_Swift

class MarvelAuthenticationTests : XCTestCase {
    var sut: MarvelAuthentication!
    
    override func setUp() {
        super.setUp()
        sut = MarvelAuthentication()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTimestamp_ShouldChangeAcrossInvocations() {
        let ts1 = sut.timestamp()
        let ts2 = sut.timestamp()
        
        XCTAssertNotEqual(ts1, ts2);
    }
    
    func testPublicKey_ShouldHave32Characters() {
        let key = sut.publicKey
        
        XCTAssertEqual(key.characters.count, 32)
    }
    
    func testPrivateKey_ShouldHave40Characters() {
        let key = sut.privateKey
        
        XCTAssertEqual(key.characters.count, 40)
    }
    
    func testMd5OfKnownString_ShouldYieldKnownResult() { // http://tools.ietf.org/html/rfc1321
        let md5 = sut.md5("abc")
        
        XCTAssertEqual(md5, "900150983cd24fb0d6963f7d28e17f72")
    }
    
    func testUrlParameters_ShouldHaveTimestampPublicKeyAndHashedConcatenation() {
        var timestampCount = 0
        sut.timestamp = {
            timestampCount += 1
            return "Timestamp\(timestampCount)"
        }
        sut.privateKey = "Private"
        sut.publicKey = "Public"
        sut.md5 = { str in return "MD5" + str + "MD5" }
        
        let params = sut.urlParameters
        
        XCTAssertEqual(params, "&ts=Timestamp1&apikey=Public&hash=MD5Timestamp1PrivatePublicMD5")
    }

}