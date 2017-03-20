import XCTest
@testable import MarvelBrowserSwift

class FetchCharactersResponseBuilderTests : XCTestCase {

    func testInit_WithNonDictionaryData_ShouldCaptureNilInBuilder() {
        let dict: [String: Any] = ["data": 123]

        let sut = FetchCharactersResponseBuilder(dictionary: dict)
    }
}
