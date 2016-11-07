//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class MockURLSession: URLSessionProtocol {
    private var dataTaskCallCount = 0
    private var dataTaskURL: URL?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskURL = url
        return URLSessionDataTask()
    }

    func verifyDataTask(urlMatcher: ((URL?) -> Bool)) {
        XCTAssertEqual(dataTaskCallCount, 1, "call count")
        XCTAssertTrue(urlMatcher(dataTaskURL), "Actual URL was \(dataTaskURL)")
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

}
