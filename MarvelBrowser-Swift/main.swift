//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import UIKit

let argsCount = Int(CommandLine.argc)
let argsRawPointer = UnsafeMutableRawPointer(CommandLine.unsafeArgv)
let args = argsRawPointer.bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: argsCount)

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass: AnyClass = isRunningTests ? TestingAppDelegate.self : AppDelegate.self

UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass))
