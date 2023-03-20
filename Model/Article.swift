//
//  Article.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 20/3/23.
//

import Foundation

struct ArticleResponse: Decodable {
  let articles: [Article]
}

struct Article: Decodable, Identifiable {
  let title: String
  let description: String?
  var id: String { title }
}
