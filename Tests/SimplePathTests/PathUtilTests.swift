//
//  PathUtilTests.swift
//  SimplePathTests
//
//  Created by Ramon Torres on 10/22/17.
//  Copyright © 2017 Ramon Torres. All rights reserved.
//

import XCTest
@testable import SimplePath

class PathUtilTests: XCTestCase {

    func testExists() {
        let wd = FileManager.default.currentDirectoryPath

        XCTAssertTrue(Path.exists(wd))
        XCTAssertFalse(Path.exists(wd + "/nothing"))
    }

    func testIsDir() {
        let wd = FileManager.default.currentDirectoryPath

        XCTAssertTrue(Path.isDir(wd))
        XCTAssertFalse(Path.isDir(wd + "/nothing"))
        XCTAssertFalse(Path.isDir(wd + "/Package.swift"))
    }

    // For Linux
    static var allTests = [
        ("testExists", testExists),
        ("testIsDir", testIsDir)
    ]

}
