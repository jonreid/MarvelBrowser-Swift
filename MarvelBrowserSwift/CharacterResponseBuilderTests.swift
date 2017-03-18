//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt


import XCTest
@testable import MarvelBrowserSwift

class CharacterResponseBuilderTests : XCTestCase {
    var sut: CharacterResponseBuilder!

    override func setUp() {
        super.setUp()
        sut = CharacterResponseBuilder()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testParseDictionary_WithNonStringName_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["name": 123]

        sut.parse(dictionary: dict)

        XCTAssertNil(sut.name)
    }

    func testParseDictionary_WithName_ShouldCaptureValueInBuilder() {
        let dict: [String: Any] = ["name": "NAME"]

        sut.parse(dictionary: dict)

        XCTAssertEqual(sut.name, "NAME")
    }

    func testBuild_ShouldHaveGivenName() {
        let dict: [String: Any] = ["name": "NAME"]
        sut.parse(dictionary: dict)

        let response: CharacterResponse = sut.build()

        XCTAssertEqual(response.name, "NAME")
    }
}
