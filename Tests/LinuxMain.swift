
import XCTest
@testable import SimplePath

XCTMain([
    testCase(PathBasicTests.allTests),
    testCase(PathFormatTests.allTests),
    testCase(PathAbsoluteRelativeTests.allTests)
    testCase(PathUtilTests.allTests)
])
