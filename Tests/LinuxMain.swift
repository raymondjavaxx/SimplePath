
import XCTest
@testable import SimplePathTests

XCTMain([
    testCase(PathBasicTests.allTests),
    testCase(PathFormatTests.allTests),
    testCase(PathAbsoluteRelativeTests.allTests),
    testCase(PathUtilTests.allTests)
])
