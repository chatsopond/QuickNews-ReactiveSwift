//
//  ChatBubbleView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import SwiftUI

struct ChatBubbleView: View {
  let viewModel: ChatBubbleViewModel
  var body: some View {
    HStack {
      if viewModel.isUserMessage {
        Spacer()
      }
      Text(viewModel.message)
        .foregroundColor(viewModel.isUserMessage ? .white : .black)
        .frame(alignment: viewModel.isUserMessage ? .trailing : .leading)
        .multilineTextAlignment(viewModel.isUserMessage ? .trailing : .leading)
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 16)
            .fill(
              viewModel.isUserMessage ? Color.blue.gradient : Color.white.gradient)
        )
        .clipped()
        .shadow(color: .gray.opacity(0.125), radius: 2, x: 0, y: -2)
        .background(alignment: viewModel.isUserMessage ? .trailing : .leading) {
          Image(systemName: "arrowtriangle." + (viewModel.isUserMessage ? "right" : "left") + ".fill")
            .foregroundStyle(
              viewModel.isUserMessage ? Color.blue.gradient : Color.white.gradient
            )
            .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: -2)
            .offset(x: viewModel.isUserMessage ? 10 : -10, y: 0)
        }
      if !viewModel.isUserMessage {
        Spacer()
      }
    }
    .listRowSeparator(.hidden)
  }
}

struct ChatBubbleView_Previews: PreviewProvider {
  static var previews: some View {
    List {
      ChatBubbleView(viewModel: .init(message: "Hello, Me", isUserMessage: true))
      ChatBubbleView(viewModel: .init(message: "Hello, You", isUserMessage: false))
    }
    .scrollContentBackground(.hidden)
  }
}
