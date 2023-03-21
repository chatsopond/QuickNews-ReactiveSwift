//
//  SampleAPIResponseView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 21/3/23.
//

import SwiftUI

struct SampleAPIResponseView: View {
  @StateObject var viewModel: SampleAPIResponseViewModel
  init(_ viewModel: SampleAPIResponseViewModel) {
    self._viewModel = .init(wrappedValue: viewModel)
  }
  var body: some View {
    ZStack {
      if viewModel.text.isEmpty {
        ProgressView()
      } else {
        Text(viewModel.text)
      }
    }
  }
}
