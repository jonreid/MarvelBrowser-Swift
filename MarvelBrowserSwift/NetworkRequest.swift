//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionTaskProtocol: class {
    func resume()
}

extension URLSessionTask: URLSessionTaskProtocol {}

class NetworkRequest {
    var currentTask: URLSessionTaskProtocol?

    func start(_ task: URLSessionTaskProtocol) {
        task.resume()
    }
}
