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
        let ts1 = sut.timestamp
        let ts2 = sut.timestamp
        
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
    
}
