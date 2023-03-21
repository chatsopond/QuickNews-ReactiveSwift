//
//  APIListViewModel.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 21/3/23.
//

import Foundation
import Moya
import ReactiveMoya
import ReactiveSwift

/// APIListViewModel is a class that manages the data and API requests for the SampleAPI.
class APIListViewModel: ObservableObject {
  let sampleAPIProvider = MoyaProvider<SampleAPI>()

  /// Published property to hold `SampleAPIResponseViewModel` and notify UI of changes
  @Published var sampleAPIResponseViewModels: [SampleAPIResponseViewModel] = []

  init() {
  }
}

// MARK: - APIs

extension APIListViewModel {
  /// Requests the current time from the SampleAPI and updates the `sampleAPIResponseViewModels` array.
  func getNow() {
    let signal = sampleAPIProvider
      .reactive
      .request(.getTime)
    let viewModel = SampleAPIResponseViewModel(signal: signal)
    sampleAPIResponseViewModels.insert(viewModel, at: 0)
  }

  /// Requests a random integer between the specified lower and upper bounds from the SampleAPI and updates the `sampleAPIResponseViewModels` array.
  func getRandomInteger(_ lowerbound: Int, _ upperbound: Int) {
    let signal = sampleAPIProvider
      .reactive
      .request(.getRandomInteger(lowerBound: lowerbound, upperBound: upperbound))
    let viewModel = SampleAPIResponseViewModel(signal: signal)
    sampleAPIResponseViewModels.insert(viewModel, at: 0)
  }
}
