//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt


import XCTest
@testable import MarvelBrowserSwift

class CharacterResponseBuilderTests : XCTestCase {

    func testInit_WithNonStringName_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["name": 123]

        let sut = CharacterResponseBuilder(dictionary: dict)

        XCTAssertNil(sut.name)
    }

    func testInit_WithName_ShouldCaptureValueInBuilder() {
        let dict: [String: Any] = ["name": "NAME"]

        let sut = CharacterResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.name, "NAME")
    }

    func testBuild_ShouldHaveGivenName() {
        let dict: [String: Any] = ["name": "NAME"]
        let sut = CharacterResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.name, "NAME")
    }

    func testBuild_RequiresName() {
        let dict: [String: Any] = [:]
        let sut = CharacterResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertNil(response)
    }
}
