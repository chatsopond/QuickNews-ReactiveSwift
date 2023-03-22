//
//  ReminderEditingViewModel.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import Foundation

/// `ReminderEditingViewModel` is an ObservableObject for managing the properties of a `Reminder` object
/// during the creation or editing process.
class ReminderEditingViewModel: ObservableObject {
  /// The title of the `Reminder` object, published for SwiftUI to observe and update.
  @Published var title = ""

  /// The priority of the `Reminder` object, published for SwiftUI to observe and update.
  @Published var priority: Reminder.Priority = .none

  /// Called when the "Done" button is pressed, creates a new `Reminder` object with the entered title
  /// and priority, and calls the `completion` closure with the created `Reminder`.
  ///
  /// - Parameter completion: An optional closure that takes the created `Reminder` as an argument.
  func onDoneDidPress(completion: ((Reminder) -> Void)?) {
    let reminder = Reminder()
    reminder.title = title
    reminder.priority = priority
    completion?(reminder)
  }
}
