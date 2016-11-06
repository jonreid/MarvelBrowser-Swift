//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import XCTest
@testable import MarvelBrowserSwift

class FetchCharactersMarvelServiceTests : XCTestCase {

    func testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint() {
        let sut = FetchCharactersMarvelService(session: URLSession.shared)
    }

}
