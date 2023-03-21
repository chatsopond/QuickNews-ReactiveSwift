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
  /// Published property to hold `SampleAPIResponse` and notify UI of changes
  @Published var responses: [SampleAPIResponse] = []

  let sampleAPIProvider = MoyaProvider<SampleAPI>()

  /// Signal for observing the coming `SampleAPIResponse`
  var sampleAPIResponseSignal: Signal<SampleAPIResponse, Error>?
  /// Observer for sending the new `SampleAPIResponse`
  var sampleAPIResponseObserver: Signal<SampleAPIResponse, Error>.Observer?

  /// CompositeDisposable to manage the lifecycle of the subscriptions
  let compositeDisposable = CompositeDisposable()

  init() {
    // Create a Signal
    (sampleAPIResponseSignal, sampleAPIResponseObserver) =
    Signal<SampleAPIResponse, Error>.pipe(disposable: compositeDisposable)

    // Observe the SampleAPI response signal
    sampleAPIResponseSignal?
      .observeResult { [weak self] result in
        guard let self else { return }
        switch result {
        case .success(let response):
          DispatchQueue.main.async {
            self.responses.insert(response, at: 0)
          }
        case .failure(let error):
          DispatchQueue.main.async {
            self.responses.append(.init(id: UUID(), result: error.localizedDescription))
          }
        }
      }
  }
}

// MARK: - APIs

extension APIListViewModel {
  /// Requests the current time from the SampleAPI and updates the responses array.
  func getNow() {
    sampleAPIProvider
      .reactive
      .request(.getTime)
      .start { [weak self] event in
        guard let self else { return }
        switch event {
        case let .value(response):
          do {
            let object = try JSONDecoder().decode(SampleAPIResponse.self, from: response.data)
            self.sampleAPIResponseObserver?.send(value: object)
          } catch {
            print(error)
          }
        case let .failed(error):
          print(error)
        default:
          break
        }
      }
  }
  
  /// Requests a random integer between the specified lower and upper bounds from the SampleAPI and updates the responses array.
  func getRandomInteger(_ lowerbound: Int, _ upperbound: Int) {
    sampleAPIProvider
      .reactive
      .request(.getRandomInteger(lowerBound: lowerbound, upperBound: upperbound))
      .start { [weak self] event in
        guard let self else { return }
        switch event {
        case let .value(response):
          do {
            let object = try JSONDecoder().decode(SampleAPIResponse.self, from: response.data)
            self.sampleAPIResponseObserver?.send(value: object)
          } catch {
            print(error)
          }
        case let .failed(error):
          print(error)
        default:
          break
        }
      }
  }
}