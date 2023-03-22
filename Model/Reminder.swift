//
//  Reminder.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import Foundation
import RealmSwift

/// `Reminder` is a RealmSwift `Object` subclass representing a reminder item.
class Reminder: Object, Identifiable {
  /// The unique identifier for the `Reminder`.
  @objc dynamic var id = UUID().uuidString

  /// The title of the `Reminder`.
  @objc dynamic var title = ""

  /// A private property that stores the raw value of the reminder's priority for persistence.
  @objc dynamic private var priorityRawValue = Priority.none.rawValue

  /// The priority level of the `Reminder`, such as none, low, medium, or high.
  var priority: Priority {
    get {
      return Priority(rawValue: priorityRawValue) ?? .none
    }
    set {
      priorityRawValue = newValue.rawValue
    }
  }

  /// Specifies the primary key for the `Reminder` class.
  override static func primaryKey() -> String? {
    return "id"
  }
}

/// Extension to add an `Identifiable` and `CaseIterable` `Priority` enum to the `Reminder` class.
extension Reminder {
  enum Priority: String, CaseIterable, Identifiable {
    case none, low, medium, high

    /// Unique identifier for the `Priority` enum case.
    var id: String { rawValue }
  }
}
