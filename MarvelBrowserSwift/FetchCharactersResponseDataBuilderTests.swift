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

    func testParseDictionary_WithIntegerTotal_ShouldCaptureValueInBuilder() {
        let dict: [String: Any] = ["total": 123]

        sut.parse(dictionary: dict)

        XCTAssertEqual(sut.total, 123)
    }

    func testParseDictionary_WithNonArrayResult_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["results": ["name": "DUMMY"]]

        sut.parse(dictionary: dict)

        XCTAssertNil(sut.results)
    }
    
    func testParseDictionary_WithOneResultThatIsNotDictionary_ShouldCaptureArraySizeZeroInBuilder() {
        let dict: [String: Any] = ["results": ["DUMMY"]]

        sut.parse(dictionary: dict)

        XCTAssertEqual(sut.results?.count ?? 0, 0)
    }

    func testParseDictionary_WithOneResult_ShouldCaptureOneCharacterInBuilder() {
        let dict: [String: Any] = ["results": [
                ["name": "ONE"],
        ]]

        sut.parse(dictionary: dict)

        XCTAssertEqual(sut.results?.count, 1)
        XCTAssertEqual(sut.results?[0].name, "ONE")
    }

    func testParseDictionary_WithTwoResult_ShouldCaptureTwoCharactersInBuilder() {
        let dict: [String: Any] = ["results": [
                ["name": "ONE"],
                ["name": "TWO"],
        ]]

        sut.parse(dictionary: dict)

        XCTAssertEqual(sut.results?.count, 2)
        XCTAssertEqual(sut.results?[0].name, "ONE")
        XCTAssertEqual(sut.results?[1].name, "TWO")
    }
}
