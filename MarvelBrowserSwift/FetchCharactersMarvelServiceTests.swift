//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class MockURLSession: URLSessionProtocol {
    var dataTaskCallCount = 0

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        return URLSessionDataTask()
    }
}

class FetchCharactersMarvelServiceTests : XCTestCase {

    func testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint() {
        let mockURLSession = MockURLSession()
        let sut = FetchCharactersMarvelService(session: mockURLSession)
        let requestModel = FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)

        sut.fetchCharacters(requestModel: requestModel)

        XCTAssertEqual(mockURLSession.dataTaskCallCount, 1)
    }

}
