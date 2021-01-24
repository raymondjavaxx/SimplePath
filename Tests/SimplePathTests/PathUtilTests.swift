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
        let workingDirectory = FileManager.default.currentDirectoryPath

        XCTAssertTrue(Path.exists(workingDirectory))
        XCTAssertFalse(Path.exists(workingDirectory + "/nothing"))
    }

    func testIsFile() {
        let workingDirectory = FileManager.default.currentDirectoryPath

        XCTAssertFalse(Path.isFile(workingDirectory))
        XCTAssertFalse(Path.isFile(workingDirectory + "/nothing.txt"))
        XCTAssertTrue(Path.isFile(workingDirectory + "/Package.swift"))
    }

    func testIsDir() {
        let workingDirectory = FileManager.default.currentDirectoryPath

        XCTAssertTrue(Path.isDir(workingDirectory))
        XCTAssertFalse(Path.isDir(workingDirectory + "/nothing"))
        XCTAssertFalse(Path.isDir(workingDirectory + "/Package.swift"))
    }

    // For Linux
    static var allTests = [
        ("testExists", testExists),
        ("testIsFile", testIsFile),
        ("testIsDir", testIsDir)
    ]

}
