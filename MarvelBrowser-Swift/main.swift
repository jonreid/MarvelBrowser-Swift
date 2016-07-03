//  TDD sample app MarvelBrowser-Swift by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass: AnyClass = isRunningTests ? TestingAppDelegate.self : AppDelegate.self
UIApplicationMain(Process.argc,
        UnsafeMutablePointer<UnsafeMutablePointer<CChar>>(Process.unsafeArgv),
        nil,
        NSStringFromClass(appDelegateClass))
