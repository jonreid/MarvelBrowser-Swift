//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

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

    func testParse_WithCode200() {
        let jsonData = "{\"code\":200}".data(using: .utf8)!

        let response = sut.parse(jsonData: jsonData)

        XCTAssertEqual(response.code, 200)
    }

    func testParse_WithCode409() {
        let jsonData = "{\"code\":409}".data(using: .utf8)!

        let response = sut.parse(jsonData: jsonData)

        XCTAssertEqual(response.code, 409)
    }

}
