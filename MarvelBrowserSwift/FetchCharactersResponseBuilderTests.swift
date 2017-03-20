import XCTest
@testable import MarvelBrowserSwift

class FetchCharactersResponseBuilderTests : XCTestCase {

    func testInit_WithNonDictionaryData_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["data": 123]

        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        XCTAssertNil(sut.data)
    }

    func testInit_WithData_ShouldCaptureValueInBuilder() {
        let dict: [String: Any] = ["data": ["offset": 123]]

        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        XCTAssertEqual(sut.data?.offset, 123)
    }

    func testBuild_WithOffset_ShouldHaveGivenOffset() {
        let dict: [String: Any] = ["data": ["offset": 123]]
        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.offset, 123)
    }

    func testBuild_WithTotal_ShouldHaveGivenTotal() {
        let dict: [String: Any] = ["data": ["total": 123]]
        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.total, 123)
    }

    func testBuild_WithResults_ShouldHaveGivenCharacters() {
        let dict: [String: Any] = ["data": ["results": [
            ["name": "NAME1"],
            ["name": "NAME2"],
        ]]]
        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        let response = sut.build()

        XCTAssertEqual(response?.characters.count, 2)
        XCTAssertEqual(response?.characters[0].name, "NAME1")
        XCTAssertEqual(response?.characters[1].name, "NAME2")
    }
}
