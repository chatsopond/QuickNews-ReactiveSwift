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
      List(viewModel.sampleAPIResponseViewModels) { sampleViewModel in
        SampleAPIResponseView(sampleViewModel)
      }
      .animation(.default, value: viewModel.sampleAPIResponseViewModels)
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
