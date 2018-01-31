//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2018 Jonathan M. Reid. See LICENSE.txt

import Foundation

let defaultPrecondition = { Swift.precondition($0, $1, file: $2, line: $3) }
var evaluatePrecondition: (Bool, String, StaticString, UInt) -> Void = defaultPrecondition

func precondition(_ condition: @autoclosure () -> Bool,
                  _ message: @autoclosure () -> String = "",
                  file: StaticString = #file,
                  line: UInt = #line) {
    evaluatePrecondition(condition(), message(), file, line)
}
