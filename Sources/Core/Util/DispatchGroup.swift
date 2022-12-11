import Foundation

extension DispatchGroup {
  /// Gives queued async work time to enter the group before waiting synchronously for the previously submitted work to complete.
  ///
  /// - Parameter timeout: The maximum duration in seconds to wait.
  /// - Returns: A result value indicating whether the method returned due to a timeout.
  func yieldAndWait(timeout: TimeInterval) -> DispatchTimeoutResult {
    self.enter()
    DispatchQueue.global(qos: .background).async {
      self.leave()
    }
    return self.wait(timeout: .now() + .milliseconds(Int(timeout * 1000)))
  }
}
