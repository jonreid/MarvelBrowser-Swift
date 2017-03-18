//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class FetchCharactersResponseDataBuilderTests : XCTestCase {
    var sut: FetchCharactersResponseDataBuilder!

    override func setUp() {
        super.setUp()
        sut = FetchCharactersResponseDataBuilder()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testParseDictionary_WithNonIntegerOffset_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["offset": "123"]

        sut.parse(dictionary: dict)

        XCTAssertNil(sut.offset)
    }

    func testParseDictionary_WithIntegerOffset_ShouldCaptureValueInBuilder() {
        let dict: [String: Any] = ["offset": 123]

        sut.parse(dictionary: dict)

        XCTAssertEqual(sut.offset, 123)
    }

    func testParseDictionary_WithNonIntegerTotal_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["total": "123"]

        sut.parse(dictionary: dict)

        XCTAssertNil(sut.total)
    }

}
