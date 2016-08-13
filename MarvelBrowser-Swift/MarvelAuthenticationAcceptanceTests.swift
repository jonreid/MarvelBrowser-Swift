//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowser_Swift

class MarvelAuthenticationAcceptanceTests : XCTestCase {

    func testValidCallToMarvel_ShouldGetHTTPStatusCode200() {
        let queryWithoutAuth = "https://gateway.marvel.com/v1/public/characters?nameStartsWith=Spider"
        let fullQuery = queryWithoutAuth + MarvelAuthentication.init().urlParameters()
        guard let validQueryUrl = URL(string: fullQuery) else {
            XCTFail("Invalid URL '\(fullQuery)'")
            return
        }
        
        let promise = expectation(description: "Status code: 200")
        startDataTask(with: validQueryUrl) { data, response, error in
            if error != nil {
                XCTFail("Error: \(error!.localizedDescription)")
                return
            }
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func startDataTask(with url: URL, completionHandler: (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            completionHandler(data, response, error)
        }
        dataTask.resume()
    }
    
}
