//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

@testable import MarvelBrowserSwift
import XCTest

// swiftlint:disable implicitly_unwrapped_optional

class PartialMockURLSessionDataTask: URLSessionDataTask {
    private var resumeCallCount = 0

    override func resume() {
        resumeCallCount += 1
    }

    func verifyResume(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(resumeCallCount, 1, "call count", file: file, line: line)
    }
}

class MockURLSession: URLSessionProtocol {
    var dataTaskReturnValue: URLSessionDataTask!
    private var dataTaskCallCount = 0
    private var dataTaskLastURL: URL?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void)
                    -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskLastURL = url
        return dataTaskReturnValue
    }

    func verifyDataTask(urlMatcher: ((URL?) -> Bool), file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(dataTaskCallCount, 1, "call count", file: file, line: line)
        XCTAssertTrue(urlMatcher(dataTaskLastURL), "Actual URL was \(String(describing: dataTaskLastURL))",
                                 file: file, line: line)
    }
}

class FetchCharactersMarvelServiceTests: XCTestCase {
    var mockDataTask: PartialMockURLSessionDataTask!
    var mockURLSession: MockURLSession!
    var sut: FetchCharactersMarvelService!

    override func setUp() {
        super.setUp()
        mockDataTask = PartialMockURLSessionDataTask()
        mockURLSession = MockURLSession()
        mockURLSession.dataTaskReturnValue = mockDataTask
        sut = FetchCharactersMarvelService(session: mockURLSession, authParametersGenerator: { return "" })
    }

    override func tearDown() {
        mockDataTask = nil
        mockURLSession = nil
        sut = nil
        super.tearDown()
    }

    private func dummyRequestModel() -> FetchCharactersRequestModel {
        return FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)
    }

    func testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint() {
        sut.fetchCharacters(requestModel: dummyRequestModel(), networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.host == "gateway.marvel.com" })
    }

    func testFetchCharacters_ShouldMakeDataTaskWithSecureConnection() {
        sut.fetchCharacters(requestModel: dummyRequestModel(), networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.scheme == "https" })
    }

    func testFetchCharacters_ShouldMakeDataTaskForCharactersAPI() {
        sut.fetchCharacters(requestModel: dummyRequestModel(), networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in url?.path == "/v1/public/characters" })
    }

    func testFetchCharacters_WithNamePrefix_ShouldMakeDataTaskWithQueryForNameStartsWith() {
        let requestModel = FetchCharactersRequestModel(namePrefix: "NAME", pageSize: 10, offset: 30)

        sut.fetchCharacters(requestModel: requestModel, networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in
            url?.hasQuery(name: "nameStartsWith", value: "NAME") ?? false
        })
    }

    func testFetchCharacters_WithNamePrefix_ShouldHandleSpacesInNameStartsWith() {
        let requestModel = FetchCharactersRequestModel(namePrefix: "ab cd", pageSize: 10, offset: 30)

        sut.fetchCharacters(requestModel: requestModel, networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in
            url?.hasQuery(name: "nameStartsWith", value: "ab cd") ?? false
        })
    }

    func testFetchCharacters_WithPageSize_ShouldMakeDataTaskWithQueryForLimit() {
        let requestModel = FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)

        sut.fetchCharacters(requestModel: requestModel, networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in
            url?.hasQuery(name: "limit", value: "10") ?? false
        })
    }

    func testFetchCharacters_WithOffset_ShouldMakeDataTaskWithQueryForOffset() {
        let requestModel = FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)

        sut.fetchCharacters(requestModel: requestModel, networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in
            url?.hasQuery(name: "offset", value: "30") ?? false
        })
    }

    func testFetchCharacters_ShouldIncludeGeneratedAuthenticationParameters() {
        let sutWithAuthParameters = FetchCharactersMarvelService(
                session: mockURLSession,
                authParametersGenerator: { return "&FOO=BAR" })

        sutWithAuthParameters.fetchCharacters(requestModel: dummyRequestModel(), networkRequest: NetworkRequest())

        mockURLSession.verifyDataTask(urlMatcher: { url in
            url?.hasQuery(name: "FOO", value: "BAR") ?? false
        })
    }

    func testFetchCharacters_ShouldStartDataTask() {
        sut.fetchCharacters(requestModel: dummyRequestModel(), networkRequest: NetworkRequest())

        mockDataTask.verifyResume()
    }

}
