//
//  ReminderListViewModel.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import Foundation
import RealmSwift
import KeychainSwift

/// `ReminderListViewModel` is an ObservableObject for managing a list of `Reminder` objects.
/// It handles the creation, storage, and retrieval of encrypted reminders using Realm and KeychainSwift.
class ReminderListViewModel: ObservableObject {
  /// The Realm.Configuration object for setting up the encrypted Realm.
  var configuration: Realm.Configuration?

  /// The Realm instance used for managing `Reminder` objects.
  var realm: Realm?

  /// The encryption key used to encrypt/decrypt the Realm.
  var encryptionKey: Data?

  /// An array of `Reminder` objects, published for SwiftUI to observe and display.
  @Published var reminders: [Reminder] = []

  /// The KeychainSwift instance used for managing the encryption key.
  private let keychain = KeychainSwift()

  /// A string identifier for storing and retrieving the encryption key in KeychainSwift.
  private let encryptionKeyIdentifier = "realm_encryption_key"

  init() {
    // Retrieve encryption key from keychain or create and store a new one.
    encryptionKey = keychain.getData(encryptionKeyIdentifier) ?? createAndStoreEncryptionKey()

    // Configure and set up the encrypted Realm.
    configuration = Realm.Configuration(encryptionKey: encryptionKey)
    setupRealm()
  }

  /// Creates a new encryption key and stores it in KeychainSwift.
  ///
  /// - Returns: The generated encryption key as Data.
  private func createAndStoreEncryptionKey() -> Data {
    let encryptionKey = generateEncryptionKey()
    keychain.set(encryptionKey, forKey: encryptionKeyIdentifier)
    return encryptionKey
  }

  /// Sets up the encrypted Realm, initializes the `reminders` array, and sets the `realm` instance.
  private func setupRealm() {
    guard let encryptionKey = encryptionKey else {
      fatalError("Impossible state")
    }

    let config = Realm.Configuration(encryptionKey: encryptionKey)
    do {
      let realm = try Realm(configuration: config)
      self.realm = realm
      let reminders = realm.objects(Reminder.self)
      self.reminders = Array(reminders)
    } catch {
      fatalError("Failed to open encrypted Realm: \(error)")
    }
  }
}

// MARK: - SwiftUI

extension ReminderListViewModel {
  /// Deletes the reminders at the specified offsets in the list.
  ///
  /// - Parameter indexSet: The indices of the reminders to be deleted.
  func delete(atOffsets indexSet: IndexSet) {
    let subReminders = reminders.indices
      .filter { indexSet.contains($0) }
      .map { reminders[$0] }
    // Remove from Realm
    subReminders.forEach { delete($0) }
    // Remove from Published
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      self.reminders.remove(atOffsets: indexSet)
    }
  }
}

// MARK: - Realm CRUD

extension ReminderListViewModel {
  /// Adds a `Reminder` to the Realm and inserts it at the beginning of the `reminders` array.
  ///
  /// - Parameter reminder: The `Reminder` object to be added.
  func add(_ reminder: Reminder) {
    guard let realm = realm else { return }
    try? realm.write {
      realm.add(reminder)
      DispatchQueue.main.async {
        self.reminders.insert(reminder, at: 0)
      }
    }
  }

  /// Deletes a `Reminder` from the Realm.
  ///
  /// - Parameter reminder: The `Reminder` object to be deleted.
  func delete(_ reminder: Reminder) {
    guard let realm = realm else { return }
    try? realm.write {
      realm.delete(reminder)
    }
  }
}
