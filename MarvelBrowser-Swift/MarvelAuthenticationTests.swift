//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowser_Swift

class MarvelAuthenticationTests : XCTestCase {

    func testTimestamp_ShouldChangeAcrossInvocations() {
        let sut = MarvelAuthentication()
        let ts1 = sut.timestamp()
        let ts2 = sut.timestamp()
        
        XCTAssertNotEqual(ts1, ts2);
    }

}
