//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

@testable import MarvelBrowserSwift
import XCTest

// swiftlint:disable implicitly_unwrapped_optional

class MarvelAuthenticationTests: XCTestCase {
    var sut: MarvelAuthentication!
    
    override func setUp() {
        super.setUp()
        sut = MarvelAuthentication()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
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
        sut.privateKey = "Private"
        sut.publicKey = "Public"
        sut.md5 = { str in return "MD5" + str + "MD5" }
        
        let params = sut.urlParameters(timestamp: "Timestamp")
        
        XCTAssertEqual(params, "&ts=Timestamp&apikey=Public&hash=MD5TimestampPrivatePublicMD5")
    }

    func testUrlParameters_ShouldChangeAcrossInvocations() {
        let params1 = sut.urlParameters()
        let params2 = sut.urlParameters()
        
        XCTAssertNotEqual(params1, params2)
    }
    
}
