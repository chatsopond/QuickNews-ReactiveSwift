//
//  SampleAPI.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 21/3/23.
//

import Foundation
import Moya
import ReactiveSwift
import ReactiveMoya

/// SampleAPI enum represents the different API endpoints available.
enum SampleAPI {
  /// Endpoint for getting the current time.
  case getTime
  /// Endpoint for getting a random integer between the specified lower and upper bounds.
  case getRandomInteger(lowerBound: Int, upperBound: Int)
}

// Extend SampleAPI to conform to Moya's TargetType protocol
extension SampleAPI: TargetType {
  /// The base URL for the API requests.
  var baseURL: URL {
    // swiftlint:disable:next force_unwrapping
    return URL(string: "https://iced-bejewled-ranunculus.glitch.me")!
  }

  /// The path for each case of the API.
  var path: String {
    switch self {
    case .getTime:
      return "/now"
    case .getRandomInteger:
      return "/randomInt"
    }
  }

  /// The HTTP method for each case of the API.
  var method: Moya.Method {
    switch self {
    case .getTime, .getRandomInteger:
      return .get
    }
  }

  /// The task for each case of the API.
  var task: Task {
    switch self {
    case .getTime:
      return .requestPlain
    case let .getRandomInteger(lowerBound, upperBound):
      return .requestParameters(parameters: ["min": lowerBound, "max": upperBound], encoding: URLEncoding.default)
    }
  }

  /// The headers for the API requests.
  var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }
}

// MARK: - ReactiveSwift + Moya

/// A custom error type for SampleAPI.
enum SampleAPIError: Error {
  case noData
}

/// A struct representing the API response, conforming to Decodable, Identifiable, and Hashable.
struct SampleAPIResponse: Decodable, Identifiable, Hashable {
  /// A unique identifier for each response object.
  var id = UUID()
  /// The result string from the API response.
  var result: String?
}
