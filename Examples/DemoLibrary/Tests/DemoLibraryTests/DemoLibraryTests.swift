@testable import DemoLibrary
import XCTest

final class DemoLibraryTests: XCTestCase {
  override class var defaultTestSuite: XCTestSuite {
    let suite = XCTestSuite(forTestCaseClass: self)
    for _ in 1..<12500 {
      for invocation in self.testInvocations {
        let testCase = DemoLibraryTests(invocation: invocation)
        suite.addTest(testCase)
      }
    }

    return suite
  }

  func testExample() async await {
//    try await Task.sleep(nanoseconds: 1_000_000)
  }
}
