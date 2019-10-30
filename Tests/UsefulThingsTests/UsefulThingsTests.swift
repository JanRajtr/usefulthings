import XCTest
@testable import UsefulThings

final class UsefulThingsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        Logger.log(prefix: "BLA", message: "TEST")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
