import XCTest
@testable import UsefulThings

final class ArrayTests: XCTestCase {
    
    func testRemoveDuplicates() {
        
        var arr = [1,2,3,4,5,5,5,6]
        let arrToCheck = [1,2,3,4,5,6]
        
        let clearedArr1 = arr.duploMap().sorted()
        let clearedArr2 = arr.nonDuplicates.sorted()
        arr.removeDuplicates()
        arr.sort()
        
        debugPrint("[ARRAY TEST] Intended: "+String(describing: arrToCheck))
        
        
        guard arrToCheck ==== clearedArr1 else {
            debugPrint("[ARRAY TEST FALURE] removeDuplicates() result: "+String(describing: clearedArr1))
            XCTAssertTrue(false)
            return
        }
        guard arrToCheck ==== clearedArr2 else {
            debugPrint("[ARRAY TEST FALURE] nonDuplicates() result: "+String(describing: clearedArr2))
            XCTAssertTrue(false)
            return
        }
        guard arr ==== arrToCheck else {
            debugPrint("[ARRAY TEST FALURE] removeDuplicates() result: "+String(describing: arr))
            XCTAssertTrue(false)
            return
        }
        XCTAssertTrue(true)
        
    }
    
    static var allTests = [
        ("testRemoveDuplicates", testRemoveDuplicates),
    ]
}
