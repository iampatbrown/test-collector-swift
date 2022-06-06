// https://github.com/apple/swift/blob/main/test/stdlib/Runtime.swift.gyb
import SwiftShims

@_silgen_name("swift_demangle")
func _stdlib_demangleImpl(
  mangledName: UnsafePointer<CChar>?,
  mangledNameLength: UInt,
  outputBuffer: UnsafeMutablePointer<CChar>?,
  outputBufferSize: UnsafeMutablePointer<UInt>?,
  flags: UInt32
) -> UnsafeMutablePointer<CChar>?

func _stdlib_demangleName(_ mangledName: String) -> String {
  return mangledName.utf8CString.withUnsafeBufferPointer { mangledNameUTF8CStr in

    let demangledNamePtr = _stdlib_demangleImpl(
      mangledName: mangledNameUTF8CStr.baseAddress,
      mangledNameLength: UInt(mangledNameUTF8CStr.count - 1),
      outputBuffer: nil,
      outputBufferSize: nil,
      flags: 0
    )

    if let demangledNamePtr = demangledNamePtr {
      let demangledName = String(cString: demangledNamePtr)
      _swift_stdlib_free(demangledNamePtr)
      return demangledName
    }
    return mangledName
  }
}
