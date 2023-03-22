//
//  ReminderListView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import SwiftUI
import RealmSwift

struct ReminderListView: View {
  @StateObject var viewModel = ReminderListViewModel()
  @State var presentedNewReminder = false

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.reminders) { reminder in
          HStack {
            Text(reminder.title)
            Spacer()
            if reminder.priority != .none {
              Text(reminder.priority.rawValue.capitalized)
                .fontWeight(.semibold)
                .foregroundColor(reminder.priority == .high ? .red : .blue)
                .padding(3)
                .background(
                  RoundedRectangle(cornerRadius: 3)
                    .stroke(lineWidth: 2)
                    .foregroundColor(reminder.priority == .high ? .red : .blue)
                )
                .scaleEffect(0.75)
            }
          }
        }
        .onDelete { indexSet in
          viewModel.delete(atOffsets: indexSet)
        }
      }
      .toolbar {
        Button {
          presentedNewReminder = true
        } label: {
          Image(systemName: "plus")
        }
      }
      .navigationTitle("Reminders")
      .sheet(isPresented: $presentedNewReminder) {
        NavigationStack {
          ReminderEditingView { reminder in
            print(reminder)
            viewModel.add(reminder)
          }
          .navigationTitle("New Reminder")
          .navigationBarTitleDisplayMode(.inline)
        }
      }
    }
  }
}

struct ReminderListView_Previews: PreviewProvider {
  static var previews: some View {
    ReminderListView()
  }
}
