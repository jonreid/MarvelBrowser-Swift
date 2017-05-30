//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
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

// swiftlint:disable implicitly_unwrapped_optional force_unwrap

class NetworkRequestTests: XCTestCase {
    var mockTask: MockURLSessionTask!

    override func setUp() {
        super.setUp()
        mockTask = MockURLSessionTask()
    }

    override func tearDown() {
        mockTask = nil
        super.tearDown()
    }

    func testStartTask_ShouldTellTaskToResume() {
        let sut = NetworkRequest()
        
        sut.start(mockTask)
        
        mockTask.verifyResume()
    }

    func testStartTask_ShouldRetainGivenTask() {
        let sut = NetworkRequest()

        sut.start(mockTask)
        
        XCTAssertTrue(sut.currentTask! === mockTask)
    }

}
