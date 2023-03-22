//
//  SampleAPIResponseViewModel.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 21/3/23.
//

import Foundation
import Moya
import ReactiveMoya
import ReactiveSwift

/// A view model class for handling SampleAPIResponse data and lifecycle.
class SampleAPIResponseViewModel: ObservableObject, Identifiable {
  let id = UUID()

  /// Published property to hold the text of the API response, and notify UI of changes.
  @Published var text: String = ""

  /// Disposable to manage the subscription.
  var disposable: Disposable?

  /// Initialize the view model with a SignalProducer.
  init(signal: SignalProducer<Response, MoyaError>) {
    print("init")
    // swiftlint:disable:next trailing_closure
    disposable = signal
      .on(completed: { [weak self] in
        guard let self else { return }
        self.disposable?.dispose()
        print("disposable was disposed. Result: \(String(describing: self.disposable?.isDisposed))")
      })
      .start { [weak self] event in
        guard let self = self else { return }
        switch event {
        case let .value(response):
          do {
            let object = try JSONDecoder().decode(SampleAPIResponse.self, from: response.data)
            DispatchQueue.main.async {
              self.text = object.result ?? "No Result"
            }
          } catch {
            DispatchQueue.main.async {
              self.text = "Decoding failed: \(error)"
            }
          }
        case let .failed(error):
          DispatchQueue.main.async {
            self.text = "Failed: \(error)"
          }
        default:
          break
        }
      }
  }

  /// Deinitialize the view model.
  deinit {
    disposable?.dispose()
    print("deinit")
  }
}

// MARK: - Equatable

extension SampleAPIResponseViewModel: Equatable {
  /// Compare two SampleAPIResponseViewModel instances for equality.
  static func == (lhs: SampleAPIResponseViewModel, rhs: SampleAPIResponseViewModel) -> Bool {
    return lhs.id == rhs.id
  }
}
