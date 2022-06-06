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
      // /../imageName(mangledName+0x0) [0x0]
      return [] // TODO: Add Linux support
      #else
      return Thread.callStackSymbols.dropFirst().map { description in
        // 0  imageName  0x0  mangledName + 0
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

extension Collection where Element == CallStack.Symbol {
  func backtrace() -> [String] {
    let maxIndexWidth = String(self.count).count
    let maxImageNameWidth = self.map { $0.imageName.count }.max() ?? 0
    return self.enumerated().map { i, symbol in
      let indexPad = String(repeating: " ", count: maxIndexWidth - String(i).count)
      let imageNamePad = String(repeating: " ", count: maxImageNameWidth - symbol.imageName.count)
      let demangledName = _stdlib_demangleName(symbol.mangeledName)
      return "\(i)\(indexPad) \(symbol.imageName)\(imageNamePad) \(demangledName)"
    }
  }
}
