//
//  ContentView.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 20/3/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      ArticleListView()
        .navigationTitle("News")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
