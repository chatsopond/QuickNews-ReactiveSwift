//
//  ReminderEditingView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import SwiftUI

struct ReminderEditingView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject var viewModel = ReminderEditingViewModel()
  let onDone: ((Reminder) -> Void)?
  init(onDone: ((Reminder) -> Void)? = nil) {
    self.onDone = onDone
  }
  var body: some View {
    List {
      Section {
        TextField("Title", text: $viewModel.title)
      }
      Picker("Priority", selection: $viewModel.priority) {
        ForEach(Reminder.Priority.allCases) { priority in
          Text(priority.rawValue.localizedCapitalized).tag(priority)
        }
      }
    }
    .toolbar {
      ToolbarItem {
        Button("Done") {
          viewModel.onDoneDidPress(completion: onDone)
          dismiss()
        }
        .fontWeight(.semibold)
      }
    }
  }
}

struct ReminderEditingView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ReminderEditingView()
        .navigationTitle("New Reminder")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}
