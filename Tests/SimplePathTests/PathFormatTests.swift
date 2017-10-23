//
//  PathFormatTests.swift
//  SimplePathTests
//
//  Created by Ramon Torres on 10/22/17.
//  Copyright © 2017 Ramon Torres. All rights reserved.
//

import XCTest
@testable import SimplePath

class PathFormatTests: XCTestCase {

    func testFormatWithDirAndBasename() {
        let result = Path.format([
            .dir: "assets/icons",
            .base: "settings.png"
        ])

        let expected = "assets/icons/settings.png"

        XCTAssertEqual(result, expected)
    }

    func testFormatWithBaseAndExtension() {
        let result = Path.format([
            .base: "logo",
            .ext: "svg"
        ])

        XCTAssertEqual(result, "logo.svg")
    }

    func testFormatWithEmptyElements() {
        let result = Path.format([:])
        XCTAssertEqual(result, "")
    }

    // For Linux
    static var allTests = [
        ("testFormatWithDirAndBasename", testFormatWithDirAndBasename),
        ("testFormatWithBaseAndExtension", testFormatWithBaseAndExtension),
        ("testFormatWithEmptyElements", testFormatWithEmptyElements)
    ]

}
