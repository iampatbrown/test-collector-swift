//  Created on 3/12/2022

import XCTest

final class DemoAppUITests: XCTestCase {
  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testExample() throws {
    let app = XCUIApplication()
    app.launch()
  }
}
