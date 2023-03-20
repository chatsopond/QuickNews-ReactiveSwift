//
//  URLRequest+Extension.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 20/3/23.
//

import Foundation
import ReactiveSwift

enum NetworkError: Error {
  case badURL
  case error(Error)
}

struct Resource<T: Decodable> {
  let url: URL
}

extension URLRequest {
  static func load<T>(resource: Resource<T>) -> SignalProducer<T, Error> {
    let coldSignal = SignalProducer<Resource<T>, Error>(value: resource)
      .flatMap(.latest) { resource -> SignalProducer<T, Error> in
        let request = URLRequest(url: resource.url)
        return URLSession.shared.reactive
          .data(with: request)
          .retry(upTo: 2)
          .flatMapError { error -> SignalProducer<(Data, URLResponse), Error> in
            print("Network error occurred: \(error)")
            return SignalProducer(error: NetworkError.error(error))
          }
          .attemptMap { data, _ -> Result<T, Error> in
            do {
              let object = try JSONDecoder().decode(T.self, from: data)
              return .success(object)
            } catch {
              return .failure(error)
            }
          }
      }
    return coldSignal
  }
}
