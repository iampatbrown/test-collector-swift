import Foundation

/// A type used to upload traces asynchronously during a test run.
struct UploadClient {
  enum UploadError: LocalizedError {
    case error(message: String)
    case unknown

    var errorDescription: String? {
      switch self {
      case .error(let message): return message
      case .unknown: return "Unknown Error"
      }
    }
  }

  private var logger: Logger?
  private var upload: (Trace) async throws -> Void
  private let uploadTasks = DispatchGroup()

  init(
    logger: Logger?,
    upload: @escaping (Trace) async throws -> Void
  ) {
    self.logger = logger
    self.upload = upload
  }

  /// Uploads a trace.
  ///
  /// - Parameter trace: The trace to upload
  /// - Returns: A `Task` responsible for performing the upload.
  @discardableResult
  func upload(trace: Trace) -> Task<Void, Error> {
    self.uploadTasks.enter()
    return Task {
      defer { self.uploadTasks.leave() }
      try await self.upload(trace)
    }
  }

  /// Waits synchronously for the previously submitted uploads to complete.
  ///
  /// - Parameter timeout: The maximum duration in seconds to wait for uploads to complete.
  func waitForUploads(timeout: TimeInterval = twoMinutes) {
    let result = self.uploadTasks.wait(timeout: timeout)
    if result == .timedOut {
      self.logger?.error("Upload client timed out before completing all uploads")
    }
  }
}

// Default timeout used by waitForUploads
private let twoMinutes: TimeInterval = 120
