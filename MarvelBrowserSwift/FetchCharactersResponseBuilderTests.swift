//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class FetchCharactersResponseBuilderTests : XCTestCase {

    var sut: FetchCharactersResponseBuilder!

    override func setUp() {
        super.setUp()
        sut = FetchCharactersResponseBuilder()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    private func jsonData(_ json: String) -> Data {
        return json.data(using: .utf8)!
    }

    func testParse_WithCode200_ShouldReturnSuccess() {
        let json = "{\"code\":200}"

        let response = sut.parseFetchCharacters(jsonData(json))

        switch response {
        case .success(_):
            break
        default:
            XCTFail("Expected success, got \(response)")
        }
    }

    func testParse_WithCode409AndStatus_ShouldReturnFailureWithStatus() {
        let json =
                "{" +
                    "\"code\":409," +
                    "\"status\":\"STATUS\"" +
                "}"

        let response = sut.parseFetchCharacters(jsonData(json))

        switch response {
        case .failure(let status):
            XCTAssertEqual(status, "STATUS")
        default:
            XCTFail("Expected failure, got \(response)")
        }
    }

    func testParse_WithMalformedJSON_ShouldReturnBadJSONFailure() {
        let json =
                "{" +
                    "\"cod"

        let response = sut.parseFetchCharacters(jsonData(json))

        switch response {
        case .failure(let status):
            XCTAssertEqual(status, "Bad JSON")
        default:
            XCTFail("Expected failure, got \(response)")
        }
    }

    func testParse_WithJSONArrayInsteadOfDictionary_ShouldReturnBadJSONFailure() {
        let json = "[]"

        let response = sut.parseFetchCharacters(jsonData(json))

        switch response {
        case .failure(let status):
            XCTAssertEqual(status, "Bad JSON")
        default:
            XCTFail("Expected failure, got \(response)")
        }
    }

    func testParse_WithNonIntegerCode_ShouldReturnBadJSONFailure() {
        let json =
                "{" +
                    "\"code\":\"409\"," +
                    "\"status\":\"STATUS\"" +
                "}"

        let response = sut.parseFetchCharacters(jsonData(json))

        switch response {
        case .failure(let status):
            XCTAssertEqual(status, "Bad JSON")
        default:
            XCTFail("Expected failure, got \(response)")
        }
    }

func testParse_WithValidFailureCodeButNoStatus_ShouldReturnBadJSONFailure() {
        let json =
                "{" +
                    "\"code\":409" +
                "}"

        let response = sut.parseFetchCharacters(jsonData(json))

        switch response {
        case .failure(let status):
            XCTAssertEqual(status, "Bad JSON")
        default:
            XCTFail("Expected failure, got \(response)")
        }
    }

}
