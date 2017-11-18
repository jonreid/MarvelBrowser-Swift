//  TDD sample app MarvelBrowser-Swift by Jon Reid, https://qualitycoding.org/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

import UIKit

let appDelegateClass: AnyClass? =
    NSClassFromString("MarvelBrowser_SwiftTests.TestingAppDelegate") ?? AppDelegate.self
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))

UIApplicationMain(CommandLine.argc,
                  args,
                  nil,
                  NSStringFromClass(appDelegateClass!)) // swiftlint:disable:this force_unwrapping
