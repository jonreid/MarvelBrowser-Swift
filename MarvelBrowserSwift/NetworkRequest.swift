//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionTaskProtocol: class {
    func resume()
}

extension URLSessionTask: URLSessionTaskProtocol {}

class NetworkRequest {
    private(set) var currentTask: URLSessionTaskProtocol?

    func start(_ task: URLSessionTaskProtocol) {
        currentTask = task
        task.resume()
    }
}
