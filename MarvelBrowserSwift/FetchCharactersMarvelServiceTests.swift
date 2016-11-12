//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class MockURLSession: URLSessionProtocol {
    private var dataTaskCallCount = 0
    private var dataTaskLastURL: URL?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskLastURL = url
        return URLSessionDataTask()
    }

    func verifyDataTask(urlMatcher: ((URL?) -> Bool), file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(dataTaskCallCount, 1, "call count", file: file, line: line)
        XCTAssertTrue(urlMatcher(dataTaskLastURL), "Actual URL was \(dataTaskLastURL)", file: file, line: line)
    }
}

class FetchCharactersMarvelServiceTests : XCTestCase {

    func testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint() {
        let mockURLSession = MockURLSession()
        let sut = FetchCharactersMarvelService(session: mockURLSession)
        let requestModel = FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)

        sut.fetchCharacters(requestModel: requestModel)

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.host == "gateway.marvel.com" })
    }

    func testFetchCharacters_ShouldMakeDataTaskWithSecureConnection() {
        let mockURLSession = MockURLSession()
        let sut = FetchCharactersMarvelService(session: mockURLSession)
        let requestModel = FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)

        sut.fetchCharacters(requestModel: requestModel)

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.scheme == "https" })
    }

}
