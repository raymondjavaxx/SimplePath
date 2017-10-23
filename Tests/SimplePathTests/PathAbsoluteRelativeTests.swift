//
//  PathAbsoluteRelativeTests.swift
//  SimplePathTests
//
//  Created by Ramon Torres on 10/22/17.
//  Copyright © 2017 Ramon Torres. All rights reserved.
//

import XCTest
@testable import SimplePath

class PathAbsoluteRelativeTests: XCTestCase {

    func testAbsolute() {
        XCTAssertTrue(Path.isAbsolute("/var/logs/test"))
        XCTAssertTrue(Path.isAbsolute("~/Documents"))
        XCTAssertFalse(Path.isAbsolute("logs/test"))
        XCTAssertFalse(Path.isAbsolute("../assets/sfx"))
    }

    func testRelative() {
        XCTAssertFalse(Path.isRelative("/var/logs/test"))
        XCTAssertTrue(Path.isRelative("logs/test"))
        XCTAssertTrue(Path.isRelative("../assets/sfx"))
    }

    // For Linux
    static var allTests = [
        ("testAbsolute", testAbsolute),
        ("testRelative", testRelative)
    ]

}
