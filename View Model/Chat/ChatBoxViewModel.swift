//
//  ChatBoxViewModel.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import Foundation
import SwiftUI

struct ChatBubbleViewModel: Identifiable, Hashable {
  let id = UUID()
  let message: String
  let isUserMessage: Bool
}

class ChatBoxViewModel: ObservableObject {
  let wsManager = WebSocketManager()
  @Published var text = ""
  @Published var bubbles: [ChatBubbleViewModel] = []

  init() {
    wsManager.delegate = self
  }

  // MARK: - Update UI
  @MainActor
  func resetText() {
    text = ""
  }

  @MainActor
  func insertBubble(text: String, isUserMessage: Bool) {
    let bubble = ChatBubbleViewModel(message: text, isUserMessage: isUserMessage)
    withAnimation {
      bubbles.append(bubble)
    }
  }

  // MARK: - SwiftUI

  func sendCurrentText() {
    print("send a message \(text)")
    wsManager.sendTextMessage(text)
    DispatchQueue.main.async {
      self.insertBubble(text: self.text, isUserMessage: true)
      self.resetText()
    }
  }
}

// MARK: - Ws Delegate

extension ChatBoxViewModel: WebSocketManagerDelegate {
  func receiveServerMessage(message: String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
      self.insertBubble(text: message, isUserMessage: false)
    }
  }
}
