//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class FetchCharactersResponseDataBuilderTests : XCTestCase {

    func testParseDictionary_WithNonIntegerOffset_ShouldCaptureNilInBuilder() {
        let sut = FetchCharactersResponseDataBuilder()
        let dict: [String: Any] = ["offset": "123"]

        sut.parse(dictionary: dict)

        XCTAssertNil(sut.offset)
    }

    func testParseDictionary_WithIntegerOffset_ShouldCaptureValueInBuilder() {
        let sut = FetchCharactersResponseDataBuilder()
        let dict: [String: Any] = ["offset": 123]

        sut.parse(dictionary: dict)

        XCTAssertEqual(sut.offset, 123)
    }
}
