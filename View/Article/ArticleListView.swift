//
//  ArticleListView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 20/3/23.
//

import SwiftUI

/// `ArticleListView` is a SwiftUI view that displays a list of articles
/// fetched by the `ArticleListViewModel`.
struct ArticleListView: View {
  /// An `@StateObject` to hold the instance of `ArticleListViewModel`
  /// for fetching and observing the articles.
  @StateObject var viewModel = ArticleListViewModel()
  /// The body of the view, which is a list of articles.
  var body: some View {
    List(viewModel.articles) { article in
      VStack(alignment: .leading) {
        /// Display the article title using the headline font.
        Text(article.title)
          .font(.headline)
        /// Display the article description if it exists.
        Text(article.description ?? "")
      }
    }
  }
}


struct ArticleListView_Previews: PreviewProvider {
  static var previews: some View {
    ArticleListView()
  }
}
