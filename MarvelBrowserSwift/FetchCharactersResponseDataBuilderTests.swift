//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class FetchCharactersResponseDataBuilderTests : XCTestCase {

    func testParseDictionary_WithNonIntegerOffset_ShouldCaptureNilInBuilder() {
        let sut = FetchCharactersResponseDataBuilder()
    }
}
