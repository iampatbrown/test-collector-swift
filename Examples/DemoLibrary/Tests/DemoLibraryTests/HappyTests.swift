@testable import DemoLibrary
import XCTest

final class HappyTests: XCTestCase {
  func testAlwaysSucceeds() {
    XCTAssert(true)
  }

  func testWillRunForUpTo3Seconds() {
    self.sleep(seconds: .random(in: 1...3))
    XCTAssert(true)
  }

  func testWillRunForUpTo4Seconds() {
    self.sleep(seconds: .random(in: 1...4))
    XCTAssert(true)
  }
  
  func testWillRunForUpTo5Seconds() {
    self.sleep(seconds: .random(in: 1...5))
    XCTAssert(true)
  }
  
  func testWillBeSkipped() throws {
    throw XCTSkip("This test will be skipped")
  }

 
}
