//
//  BuildkiteRunEnvironmentTests.swift
//  BuildkiteRunEnvironmentTests
//
//  Created by Pat Brown on 28/6/2022.
//

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
}
