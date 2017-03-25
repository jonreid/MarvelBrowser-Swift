//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class CharactersSliceResponseBuilderTests: XCTestCase {

    func testInit_WithNonIntegerOffset_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["offset": "123"]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertNil(sut.offset)
    }

    func testInit_WithIntegerOffset_ShouldCaptureValueInBuilder() {
        let dict: [String: Any] = ["offset": 123]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.offset, 123)
    }

    func testInit_WithNonIntegerTotal_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["total": "123"]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertNil(sut.total)
    }

    func testInit_WithIntegerTotal_ShouldCaptureValueInBuilder() {
        let dict: [String: Any] = ["total": 123]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.total, 123)
    }

    func testInit_WithNonArrayResult_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["results": ["name": "DUMMY"]]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertNil(sut.results)
    }
    
    func testInit_WithOneResultThatIsNotDictionary_ShouldCaptureArraySizeZeroInBuilder() {
        let dict: [String: Any] = ["results": ["DUMMY"]]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.results?.count ?? 0, 0)
    }

    func testInit_WithOneResult_ShouldCaptureOneCharacterInBuilder() {
        let dict: [String: Any] = ["results": [
                ["name": "ONE"],
        ]]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.results?.count, 1)
        XCTAssertEqual(sut.results?[0].name, "ONE")
    }

    func testInit_WithTwoResults_ShouldCaptureTwoCharactersInBuilder() {
        let dict: [String: Any] = ["results": [
                ["name": "ONE"],
                ["name": "TWO"],
        ]]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.results?.count, 2)
        XCTAssertEqual(sut.results?[0].name, "ONE")
        XCTAssertEqual(sut.results?[1].name, "TWO")
    }

    func testBuild_WithAllRequiredFields_ShouldHaveGivenFields() {
        let dict: [String: Any] = [
                "offset": 123,
                "total": 456,
        ]
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.offset, 123)
        XCTAssertEqual(response?.total, 456)
    }

    func testBuild_MissingOffset_ShouldReturnNil() {
        let dict: [String: Any] = [
                "total": 456,
        ]
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertNil(response)
    }

    func testBuild_MissingTotal_ShouldReturnNil() {
        let dict: [String: Any] = [
                "offset": 123,
        ]
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertNil(response)
    }

    func testBuildCharacters_WithTwoResults_ShouldBuildTwoCharacters() {
        let dict: [String: Any] = ["results": [
                ["name": "ONE"],
                ["name": "TWO"],
        ]]
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let characters = sut.buildCharacters()

        XCTAssertEqual(characters.count, 2)
        XCTAssertEqual(characters[0].name, "ONE")
        XCTAssertEqual(characters[1].name, "TWO")
    }

    func testBuildCharacters_WithTwoResultsButFirstCharacterMissingName_ShouldBuildOneCharacter() {
        let dict: [String: Any] = ["results": [
                [:],
                ["name": "TWO"],
        ]]
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let characters = sut.buildCharacters()

        XCTAssertEqual(characters.count, 1)
        XCTAssertEqual(characters[0].name, "TWO")
    }
}
