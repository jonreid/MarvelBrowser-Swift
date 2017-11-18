//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

@testable import MarvelBrowserSwift
import XCTest

class MockURLSessionTask: URLSessionTaskProtocol {
    private var resumeCallCount = 0

    func resume() {
        resumeCallCount += 1
    }
    
    func verifyResume(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(resumeCallCount, 1, "call count", file: file, line: line)
    }
}

// swiftlint:disable implicitly_unwrapped_optional force_unwrapping

class NetworkRequestTests: XCTestCase {
    var mockTask: MockURLSessionTask!
    var sut: NetworkRequest!

    override func setUp() {
        super.setUp()
        mockTask = MockURLSessionTask()
        sut = NetworkRequest()
    }

    override func tearDown() {
        mockTask = nil
        sut = nil
        super.tearDown()
    }

    func testStartTask_ShouldTellTaskToResume() {
        sut.start(mockTask)
        
        mockTask.verifyResume()
    }

    func testStartTask_ShouldRetainGivenTask() {
        sut.start(mockTask)
        
        XCTAssertTrue(sut.currentTask! === mockTask)
    }

}
