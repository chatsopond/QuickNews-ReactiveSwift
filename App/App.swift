//
//  QuickNews_ReactiveSwiftApp.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 20/3/23.
//

import SwiftUI

@main
// swiftlint:disable:next type_name attributes
struct QuickNews_ReactiveSwiftApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ChatBoxView()
          .navigationTitle("Chatbox")
          .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}
