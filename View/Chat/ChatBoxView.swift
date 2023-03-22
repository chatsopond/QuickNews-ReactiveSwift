//
//  ChatBoxView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import SwiftUI

struct ChatBoxView: View {
  @StateObject var viewModel = ChatBoxViewModel()
  var body: some View {
    List(viewModel.bubbles) { bubble in
      ChatBubbleView(viewModel: bubble)
    }
    .scrollContentBackground(.hidden)
    .safeAreaInset(edge: .bottom) {
      textInput
        .padding()
    }
  }

  var textInput: some View {
    HStack {
      TextField("Enter Message", text: $viewModel.text)
        .padding(10)
        .padding(.horizontal, 5)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 2)
            .foregroundColor(.secondary.opacity(0.25))
        )
      Button {
        // Send a message
        viewModel.sendCurrentText()
      } label: {
        Image(systemName: "chevron.up.circle.fill")
          .font(.title)
      }
    }
  }
}

struct ChatBoxView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ChatBoxView()
        .navigationTitle("Chatbox")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}
