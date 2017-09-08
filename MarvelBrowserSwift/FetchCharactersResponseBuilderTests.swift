//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

@testable import MarvelBrowserSwift
import XCTest

class FetchCharactersResponseBuilderTests: XCTestCase {

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
        let dict: [String: Any] = [
            "data": [
                "offset": 123,
                "total": 456,
            ],
        ]
        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        let response = sut.build()

        switch response {
        case let .success(responseModel):
            XCTAssertEqual(responseModel.offset, 123)
            XCTAssertEqual(responseModel.total, 456)
        default:
            XCTFail("Expected success, got \(response)")
        }
    }

    func testBuild_WithoutData_ShouldYieldFailure() {
        let dict: [String: Any] = [:]
        let sut = FetchCharactersResponseBuilder(dictionary: dict)

        let response = sut.build()

        switch response {
        case let .failure(status):
            XCTAssertEqual(status, "Bad data")
        default:
            XCTFail("Expected failure, got \(response)")
        }
    }
}
