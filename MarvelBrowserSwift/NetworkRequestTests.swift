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

class NetworkRequestTests: XCTestCase {
    
    func testStartTask_ShouldTellTaskToResume() {
        let mockTask = MockURLSessionTask()
        let sut = NetworkRequest()
        
        sut.start(mockTask)
        
        mockTask.verifyResume()
    }

    func testStartTask_ShouldRetainGivenTask() {
        let mockTask = MockURLSessionTask()
        let sut = NetworkRequest()

        sut.start(mockTask)

        sut.currentTask
    }

}
