@testable import DemoLibrary
import XCTest

final class DemoLibraryTests: XCTestCase {
  func testAlwaysSucceeds() {
    XCTAssert(true)
  }

  func testWillRunForUpTo3Seconds() {
    self.sleep(seconds: .random(in: 1...3))
    XCTAssert(true)
  }

  func testWillBeSkipped() throws {
    throw XCTSkip("This test will be skipped")
  }

  func testWillFail10PercentOfTheTime() {
    let shouldFail = Double.random(in: 0...1) < 0.1
    func foo() { bar() }
    func bar() { baz() }
    func baz() { if shouldFail { unhappyPath() } }
    func unhappyPath() { XCTFail("Unhappy path taken") }
    foo()
  }
}
