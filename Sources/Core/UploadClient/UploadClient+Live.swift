import Dispatch
import Foundation

extension UploadClient {
  /// Constructs a "live" upload client that uploads traces using an API client.
  ///
  /// - Parameters:
  ///   - api: An API client.
  ///   - logger: A logger.
  ///   - runEnvironment: The run environment to accompany uploaded traces.
  /// - Returns: A upload client that uses an api client.
  static func live(
    api: ApiClient,
    runEnvironment: RunEnvironment,
    logger: Logger? = nil
  ) -> UploadClient {
    UploadClient(
      logger: logger,
      upload: { trace in
        let testData = TestResults.json(runEnv: runEnvironment, data: [trace])
        logger?.debug("uploading \(testData)")

        do {
          let data = try await api.data(for: .upload(testData)).0
          guard let result = try? api.decode(data, as: UploadResponse.self) else {
            if let errorMessage = try? api.decode(data, as: UploadFailureResponse.self) {
              throw UploadError.error(message: errorMessage.message)
            } else {
              throw UploadError.unknown
            }
          }
          logger?.debug("Finished Upload, got response: \(result)")
        } catch {
          logger?.error("Failed to upload result, got error: \(error.localizedDescription)")
          throw error
        }
      }
    )
  }
}
