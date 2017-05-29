//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

@testable import MarvelBrowserSwift
import XCTest

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
    
    func testInit_WithTwoResults_ShouldCaptureTwoCharactersInBuilder() {
        let dict: [String: Any] = [
            "results": [
                ["name": "ONE"],
                ["name": "TWO"],
            ],
        ]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.results?.count, 2)
        XCTAssertEqual(sut.results?[0].name, "ONE")
        XCTAssertEqual(sut.results?[1].name, "TWO")
    }

    func testInit_WithTwoResultsButFirstNotDictionary_ShouldCaptureValidSecondResult() {
        let dict: [String: Any] = [
            "results": [
                "DUMMY",
                ["name": "TWO"],
            ],
        ]

        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.results?.count, 1)
        XCTAssertEqual(sut.results?[0].name, "TWO")
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

    private func addRequiredFields(to dict: [String: Any]) -> [String: Any] {
        var dictPlusData = dict
        dictPlusData["offset"] = 0
        dictPlusData["total"] = 0
        return dictPlusData
    }

    func testBuild_WithRequiredFieldsPlusTwoResults_ShouldHaveTwoCharacters() {
        let dict = addRequiredFields(to: [
                "results": [
                        ["name": "ONE"],
                        ["name": "TWO"],
                ],
        ])
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.characters.count, 2)
        XCTAssertEqual(response?.characters[0].name, "ONE")
        XCTAssertEqual(response?.characters[1].name, "TWO")
    }

    func testBuild_WithRequiredFieldsPlusTwoResultsButFirstCharacterMissingName_ShouldHaveOneCharacter() {
        let dict = addRequiredFields(to: [
                "results": [
                        [:],
                        ["name": "TWO"],
                ],
        ])
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.characters.count, 1)
        XCTAssertEqual(response?.characters[0].name, "TWO")
    }

    func testBuild_WithRequiredFieldsButNoResults_ShouldHaveEmptyCharactersArray() {
        let dict = addRequiredFields(to: [:])
        let sut = CharactersSliceResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.characters.count, 0)
    }
}
