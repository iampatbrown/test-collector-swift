
@testable import Core
import XCTest

class CallStackTests: XCTestCase {
  #if canImport(ObjectiveC)
  func testSymbols() {
    let symbols = CallStack.live.symbols()
    let demangledName = symbols.first.map { _stdlib_demangleName($0.mangeledName) }
    XCTAssertEqual(demangledName, "CoreTests.CallStackTests.testSymbols() -> ()")
  }
  #endif

  func testBacktrace() {
    let symbols: [CallStack.Symbol] = [
      .init(imageName: "Foo", mangeledName: "$s3Foo3baryyF"),
      .init(imageName: "FooBar", mangeledName: "$s6FooBar3bazyyF")
    ]
    XCTAssertEqual(
      symbols.backtrace().joined(separator: "\n"),
      """
      0 Foo    Foo.bar() -> ()
      1 FooBar FooBar.baz() -> ()
      """
    )
  }
}
