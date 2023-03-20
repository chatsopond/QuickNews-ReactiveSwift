//
//  ArticleListViewModel.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 20/3/23.
//

import os
import SwiftUI
import ReactiveSwift

/// ArticleListViewModel is a class that manages the fetching of articles
/// and updates the UI accordingly.
class ArticleListViewModel: ObservableObject {
  /// Logger for logging messages related to ArticleListViewModel
  let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? K.appIdentifer,
    category: String(describing: ArticleListViewModel.self))

  /// Published property to hold articles and notify UI of changes
  @Published var articles: [Article] = []

  /// Signal for observing the coming array of articles
  var articleSignal: Signal<[Article], Never>?
  /// Observer for sending the new array of articles
  var articleObserver: Signal<[Article], Never>.Observer?

  /// CompositeDisposable to manage the lifecycle of the subscriptions
  let compositeDisposable = CompositeDisposable()

  /// Initializer for the ArticleListViewModel
  init() {
    // Define the URL for fetching articles
    // swiftlint:disable:next force_unwrapping
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=8bfba1b8763148feb3583622592d9115")!

    // Create a Resource instance for the API request
    let resource = Resource<ArticleResponse>(url: url)

    (articleSignal, articleObserver) = Signal<[Article], Never>.pipe(disposable: compositeDisposable)
    guard let articleSignal, let articleObserver else { return }
    articleSignal
      .observeValues { [weak self] articles in
        guard let self else { return }
        DispatchQueue.main.async {
          self.articles = articles
        }
      }

    // Load the resource and start observing the SignalProducer
    let disposable = URLRequest.load(resource: resource)
      .start { [weak self] event in
        // Use a weak reference to self to avoid retain cycles
        guard let self else { return }

        // Handle different events
        switch event {
        case .value(let articleResponse):
          self.logger.log("Received value: \(String(describing: articleResponse))")
          // Update articles array with the received data
          articleObserver.send(value: articleResponse.articles)
        case .failed(let error):
          self.logger.error("Error occurred: \(error.localizedDescription, privacy: .private)")
        case .completed:
          self.logger.log("Request completed")
        case .interrupted:
          self.logger.warning("Request interrupted")
        }
      }

    // Add the disposable to the compositeDisposable
    compositeDisposable += disposable
  }

  /// Deinitializer for the ArticleListViewModel
  deinit {
    // Dispose all subscriptions when the instance is deallocated
    compositeDisposable.dispose()
  }
}
