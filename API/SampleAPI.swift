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

enum SampleAPI {
  case getTime
  case getRandomInteger(lowerBound: Int, upperBound: Int)
}

extension SampleAPI: TargetType {
  var baseURL: URL {
    // swiftlint:disable:next force_unwrapping
    return URL(string: "https://iced-bejewled-ranunculus.glitch.me")!
  }

  var path: String {
    switch self {
    case .getTime:
      return "/now"
      // swiftlint:disable:next empty_enum_arguments
    case .getRandomInteger(_, _):
      return "/randomInt"
    }
  }

  var method: Moya.Method {
    switch self {
      // swiftlint:disable:next empty_enum_arguments
    case .getTime, .getRandomInteger(_, _):
      return .get
    }
  }

  var task: Task {
    switch self {
    case .getTime:
      return .requestPlain
      // swiftlint:disable:next pattern_matching_keywords
    case .getRandomInteger(let lowerBound, let upperBound):
      return .requestParameters(parameters: ["min": lowerBound, "max": upperBound], encoding: URLEncoding.default)
    }
  }

  var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }
}

// MARK: - ReactiveSwift + Moya

enum SampleAPIError: Error {
  case noData
}

struct SampleAPIResponse: Decodable, Identifiable, Hashable {
  var id = UUID()
  var result: String?
}
