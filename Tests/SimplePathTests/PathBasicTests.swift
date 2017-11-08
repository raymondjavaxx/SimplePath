//
//  PathBasicTests.swift
//  SimplePathTests
//
//  Created by Ramon Torres on 10/22/17.
//  Copyright © 2017 Ramon Torres. All rights reserved.
//

import XCTest
@testable import SimplePath

class PathBasicTests: XCTestCase {

    func testJoin() {
        let result = Path.join([
            "/",
            "var/www",
            "/",
            "",
            "website",
            "robots.txt"
        ])

        let expected = "/var/www/website/robots.txt"

        XCTAssertEqual(result, expected)
    }

    func testSplit() {
        let result = Path.split("/storage/images/0001.jpg")

        let expected = [
            "/",
            "storage",
            "images",
            "0001.jpg"
        ]

        XCTAssertEqual(result, expected)
    }

    func testBasename() {
        XCTAssertEqual(
            Path.basename("/var/home/user/readme.txt"),
            "readme.txt"
        )

        XCTAssertEqual(
            Path.basename("data/readme.txt", ext: "txt"),
            "readme"
        )

        XCTAssertEqual(
            Path.basename("data/readme.txt", ext: "md"),
            "readme.txt"
        )
    }

    func testExtname() {
        XCTAssertEqual(
            Path.extname("/var/home/user/readme.txt"),
            "txt"
        )

        XCTAssertEqual(
            Path.extname("logo.png"),
            "png"
        )

        XCTAssertEqual(
            Path.extname("data.bin.gz"),
            "gz"
        )

        XCTAssertNil(
            Path.extname("data")
        )
    }

    func testDirname() {
        XCTAssertEqual(
            Path.dirname("/var/home/user/readme.txt"),
            "/var/home/user"
        )

        XCTAssertEqual(
            Path.dirname("/var/home/user"),
            "/var/home"
        )

        XCTAssertEqual(
            Path.dirname("relative/path/ninja.jpg"),
            "relative/path"
        )

        XCTAssertEqual(Path.dirname("/"), "/")

        XCTAssertEqual(Path.dirname("/test"), "/")

        XCTAssertEqual(Path.dirname("test"), "")
    }

    // For Linux
    static var allTests = [
        ("testJoin", testJoin),
        ("testSplit", testSplit),
        ("testBasename", testBasename),
        ("testExtname", testExtname),
        ("testDirname", testDirname)
    ]

}
