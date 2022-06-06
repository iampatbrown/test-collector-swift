import XCTest

extension XCTestCase {
  func sleep(seconds: TimeInterval) {
    let expectation = self.expectation(description: "Sleep")
    expectation.isInverted = true
    wait(for: [expectation], timeout: seconds)
  }
}
