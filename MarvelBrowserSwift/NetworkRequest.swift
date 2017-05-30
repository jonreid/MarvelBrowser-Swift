//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import Foundation

protocol URLSessionTaskProtocol {
    func resume()
}

extension URLSessionTask: URLSessionTaskProtocol {}

class NetworkRequest {
    func start(_ task: URLSessionTask) {
        task.resume()
    }
}
