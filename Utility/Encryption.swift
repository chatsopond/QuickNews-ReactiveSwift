//
//  Encryption.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import Foundation

/// `generateEncryptionKey()` is a function that generates a 64-byte encryption key for securely storing data.
///
/// This function uses the `SecRandomCopyBytes` function to create a random encryption key.
/// It returns the generated key as a `Data` object.
///
/// - Returns: A `Data` object representing the generated encryption key.
/// - Throws: A fatal error if the encryption key generation fails.
func generateEncryptionKey() -> Data {
  var keyData = Data(count: 64)

  // Use `withUnsafeMutableBytes` to access the mutable buffer pointer and generate the random key.
  let result = keyData.withUnsafeMutableBytes { (bytes: UnsafeMutableRawBufferPointer) -> OSStatus in
    guard let baseAddress = bytes.baseAddress else {
      return errSecParam
    }
    return SecRandomCopyBytes(kSecRandomDefault, 64, baseAddress)
  }

  // Check if the key generation was successful, otherwise throw a fatal error.
  if result == errSecSuccess {
    return keyData
  } else {
    fatalError("Failed to generate encryption key")
  }
}
