@testable import Core
import XCTest

class BuildkiteRunEnvironmentTests: XCTestCase {
  func testEnvironmentValues() {
    let runEnvironment = EnvironmentValues().runEnvironment()
    XCTAssertEqual(runEnvironment.ci, "buildkite")
    XCTAssertEqual(runEnvironment.key, "buildId")
    XCTAssertEqual(runEnvironment.url, "buildURL")
    XCTAssertEqual(runEnvironment.branch, "branch")
    XCTAssertEqual(runEnvironment.commitSha, "commit")
    XCTAssertEqual(runEnvironment.number, "buildNumber")
    XCTAssertEqual(runEnvironment.jobId, "jobId")
    XCTAssertEqual(runEnvironment.message, "message")
  }

  func testInfoPlist() {
    let runEnvironment = EnvironmentValues(getFromEnvironment: { _ in nil }).runEnvironment()
    XCTAssertEqual(runEnvironment.ci, "buildkite")
    XCTAssertEqual(runEnvironment.key, "buildId")
    XCTAssertEqual(runEnvironment.url, "buildURL")
    XCTAssertEqual(runEnvironment.branch, "branch")
    XCTAssertEqual(runEnvironment.commitSha, "commit")
    XCTAssertEqual(runEnvironment.number, "buildNumber")
    XCTAssertEqual(runEnvironment.jobId, "jobId")
    XCTAssertEqual(runEnvironment.message, "message")
  }
}
