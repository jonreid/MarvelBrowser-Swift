//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionTaskProtocol: class {
    func resume()
    func cancel()
}

extension URLSessionTask: URLSessionTaskProtocol {}

class NetworkRequest {
    private(set) var currentTask: URLSessionTaskProtocol?

    func start(_ task: URLSessionTaskProtocol) {
        precondition(currentTask == nil)
        currentTask = task
        task.resume()
    }

    func cancel() {
        currentTask?.cancel()
        currentTask = nil
    }
}
