@testable import DemoLibrary
import XCTest

final class FlackyTests: XCTestCase {
  let allTestsShouldPass = Double.random(in: 0...1) < 0.9

  func shouldFail() -> Bool {
    !self.allTestsShouldPass && Bool.random()
  }

  func testAssertNil() {
    guard self.shouldFail() else { return }
    let maybeUser: User? = User(id: 42, name: "Blob")
    XCTAssertNil(maybeUser)
  }

  func testAssertNotNil() {
    guard self.shouldFail() else { return }
    let maybeUser: User? = nil
    XCTAssertNotNil(maybeUser)
  }

  func testUnwrap() throws {
    guard self.shouldFail() else { return }
    let maybeUser: User? = nil
    let user = try XCTUnwrap(maybeUser)
    XCTAssertEqual(user.name, "Blob")
  }

  func testAssertEqual() {
    guard self.shouldFail() else { return }
    XCTAssertEqual(User(id: 42, name: "Blob"), User(id: 43, name: "Alice"))
  }

  func testAssertNotEqual() {
    guard self.shouldFail() else { return }
    XCTAssertNotEqual(User(id: 42, name: "Blob"), User(id: 42, name: "Blob"))
  }

  func testAssertIdentical() {
    guard self.shouldFail() else { return }
    XCTAssertIdentical(UserClass(id: 42, name: "Blob"), UserClass(id: 42, name: "Blob"))
  }

  func testAssertNotIdentical() {
    guard self.shouldFail() else { return }
    let user = UserClass(id: 42, name: "Blob")
    XCTAssertNotIdentical(user, user)
  }

  func testAssertEqualWithAccuracy() {
    guard self.shouldFail() else { return }
    XCTAssertEqual(42, 43.5, accuracy: 0.5)
  }

  func testAssertNotEqualWithAccuracy() {
    guard self.shouldFail() else { return }
    XCTAssertNotEqual(42, 42.1, accuracy: 0.5)
  }

  func testAssertGreaterThan() {
    guard self.shouldFail() else { return }
    XCTAssertGreaterThan(42, 43)
  }

  func testAssertGreaterThanOrEqual() {
    guard self.shouldFail() else { return }
    XCTAssertGreaterThanOrEqual(42, 43)
  }

  func testAssertLessThan() {
    guard self.shouldFail() else { return }
    XCTAssertLessThan(43, 42)
  }

  func testAssertLessThanOrEqual() {
    guard self.shouldFail() else { return }
    XCTAssertLessThanOrEqual(43, 42)
  }

  func testAssertThrowsError() {
    guard self.shouldFail() else { return }
    XCTAssertThrowsError(try divide(.pi, by: 42))
  }

  func testAssertNoThrow() {
    guard self.shouldFail() else { return }
    XCTAssertNoThrow(try divide(.pi, by: 0))
  }

  func testThrowingFunction() throws {
    guard self.shouldFail() else { return }
    _ = try divide(.pi, by: 0)
  }

  #if canImport(ObjectiveC)
  func testExpectFailure() {
    guard self.shouldFail() else { return }
    XCTExpectFailure("This test should fail (but actually passes)")
  }

  func testExpectFailureWithBlock() {
    guard self.shouldFail() else { return }
    XCTExpectFailure("This test should fail (but actually passes)") {
      XCTAssertTrue(true)
    }
  }

  func testExpectFailureWithOptions() {
    guard self.shouldFail() else { return }
    let options = XCTExpectedFailure.Options()
    options.issueMatcher = { $0.type == .thrownError }
    XCTExpectFailure("This test should throw an error", options: options)
    XCTAssertEqual(42, 43)
  }
  #endif

  func testExpectation() {
    guard self.shouldFail() else { return }
    let expectation = self.expectation(description: "Expectation")
    _ = expectation
    self.waitForExpectations(timeout: 0.1)
  }

  func testExpectationUnwaited() {
    guard self.shouldFail() else { return }
    let expectation = self.expectation(description: "Expectation")
    expectation.fulfill()
  }

  func testExpectationInverted() {
    guard self.shouldFail() else { return }
    let expectation = self.expectation(description: "Inverted Expectation")
    expectation.isInverted = true
    expectation.fulfill()
    self.waitForExpectations(timeout: 0.1)
  }

  func testAssertNoDifference() {
    guard self.shouldFail() else { return }
    // XCTAssertNoDifference(User(id: 42, name: "Blob"), User(id: 42, name: "Blob Jr."))
    XCTFail(
      """
      XCTAssertNoDifference failed: …
        User(
          id: 42
      -   name: Blob
      +   name: Blob Jr.
        )
      (First: −, Second: +)
      """
    )
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

struct User: Equatable, Identifiable { var id: Int, name: String }

class UserClass {
  let id: Int, name: String
  init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}

enum Enum {
  case foo
  case bar(Int)
  case baz(fizz: Double, buzz: String)
  case fizz(Double, buzz: String)
  case fu(bar: Int)
}

func divide(_ number: Double, by divisor: Double) throws -> Double {
  struct DivisionByZero: LocalizedError {
    let errorDescription = "Division by zero has undefined behavior"
    let failureReason = "Zero was used as the divisor"
    let recoverySuggestion = "Do not divide by zero"
  }
  guard divisor != 0 else { throw DivisionByZero() }
  return number / divisor
}
