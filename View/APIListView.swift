//
//  APIListView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 21/3/23.
//

import SwiftUI

struct APIListView: View {
  @StateObject var viewModel = APIListViewModel()
  var body: some View {
    NavigationStack {
      List(viewModel.responses) { response in
        Text(response.result ?? "No Result")
      }
      .animation(.default, value: viewModel.responses)
      .navigationTitle("API Responses")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button("Now") {
            viewModel.getNow()
          }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("Random") {
            viewModel.getRandomInteger(0, 100)
          }
        }
      }
    }
  }
}

struct APIListView_Previews: PreviewProvider {
  static var previews: some View {
    APIListView()
  }
}
