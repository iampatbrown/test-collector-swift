import Foundation

struct CallStack {
  struct Symbol {
    var imageName: String
    var mangeledName: String
  }

  var symbols: () -> [Symbol]
}

extension CallStack {
  static var live: CallStack {
    CallStack {
      #if os(Android) || os(OpenBSD)
      return []
      #elseif os(Windows)
      return [] // TODO: Add Windows support
      #elseif os(Linux)
      // /../libFoundation.so($s10Foundation6...Z+0x0) [0x0]
      return [] // TODO: Add Linux support
      #else
      return Thread.callStackSymbols.dropFirst().map { description in
        // 0  Core  0x0  $s9Core09CallStackB0C12symbolsyyF + 0
        let parts = description.split(separator: " ", maxSplits: 3)
        let imageName = String(parts[1])
        let offsetIndicator = parts[3].range(of: " + ", options: .backwards)
        let endIndex = offsetIndicator?.lowerBound ?? parts[3].endIndex
        let mangledName = String(parts[3][..<endIndex])
        return Symbol(imageName: imageName, mangeledName: mangledName)
      }
      #endif
    }
  }
}
