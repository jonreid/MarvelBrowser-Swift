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

    func testBuild_WithDataWithRequiredFields_ShouldYieldSuccessWithSlice() {
        let dict: [String: Any] = ["data": [
                "offset": 123,
                "total": 456,
        ]]
        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        let response: FetchCharactersResponseModel = sut.build()
    }
}
