//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt


import XCTest
@testable import MarvelBrowserSwift

class CharacterResponseBuilderTests : XCTestCase {
    func testParseDictionary_WithNonStringName_ShouldCaptureNilInBuilder() {
        let sut = CharacterResponseBuilder()
    }
}

