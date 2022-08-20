import Foundation
import CryptoKit

public func MD5(string: String) -> String {
    return Insecure
      .MD5
      .hash(data: string.data(using: .utf8) ?? Data())
      .map { String(format: "%02hhx", $0) }
      .joined()
}
