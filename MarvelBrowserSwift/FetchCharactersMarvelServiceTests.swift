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
    var mockURLSession: MockURLSession!
    var sut: FetchCharactersMarvelService!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = FetchCharactersMarvelService(session: mockURLSession)
    }

    override func tearDown() {
        mockURLSession = nil
        sut = nil
        super.tearDown()
    }

    private func dummyRequestModel() -> FetchCharactersRequestModel {
        return FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)
    }

    func testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint() {
        sut.fetchCharacters(requestModel: dummyRequestModel())

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.host == "gateway.marvel.com" })
    }

    func testFetchCharacters_ShouldMakeDataTaskWithSecureConnection() {
        sut.fetchCharacters(requestModel: dummyRequestModel())

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.scheme == "https" })
    }

    func testFetchCharacters_ShouldMakeDataTaskForCharactersAPI() {
        sut.fetchCharacters(requestModel: dummyRequestModel())

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.path == "/v1/public/characters" })
    }

}
