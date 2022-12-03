import Core

/// This function is automatically called by the Loader module to ensure the test collector is loaded before running any tests
@_spi(Loader)
@_cdecl("loadCollector")
public func loadCollector() {
  Core.TestCollector.load()
}
