//
//  WebSocketManager.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import Foundation
import Starscream

class WebSocketManager: WebSocketDelegate {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var socket: WebSocket!

  var delegate: WebSocketManagerDelegate?

  init() {
    // swiftlint:disable:next force_unwrapping
    let request = URLRequest(url: URL(string: "ws://localhost:8080")!)
    socket = WebSocket(request: request)
    socket.delegate = self
    socket.connect()
  }

  // MARK: - WebSocketDelegate

  func didReceive(event: WebSocketEvent, client: WebSocket) {
    switch event {
    case .connected(let headers):
      print("WebSocket connected, headers: \(headers)")
      // swiftlint:disable:next pattern_matching_keywords
    case .disconnected(let reason, let code):
      print("WebSocket disconnected, reason: \(reason), code: \(code)")
    case .text(let text):
      print("WebSocket received text: \(text)")
      delegate?.receiveServerMessage(message: text)
    case .binary(let data):
      print("WebSocket received binary data: \(data)")
    case .pong(let data):
      print("WebSocket received Pong: \(data.debugDescription)")
    case .ping(let data):
      print("WebSocket received Ping: \(data.debugDescription)")
    case .error(let error):
      print("WebSocket encountered an error: \(error?.localizedDescription ?? "Unknown error")")
    case .viabilityChanged(let isConnected):
      print("WebSocket viability changed, isConnected: \(isConnected)")
    case .reconnectSuggested(let shouldReconnect):
      print("WebSocket reconnect suggested, shouldReconnect: \(shouldReconnect)")
    case .cancelled:
      print("WebSocket connection cancelled")
    }
  }

  func websocketDidConnect(socket: WebSocketClient) {
    print("Connected to WebSocket server")
    socket.write(string: "Hello, server!")
  }

  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    print("Received message: \(text)")
  }

  func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    print("Disconnected from WebSocket server")
  }


  // MARK: - WebSocket Actions
  func sendTextMessage(_ message: String) {
    socket.write(string: message)
  }

  func sendBinaryMessage(_ data: Data) {
    socket.write(data: data)
  }

  func disconnect() {
    socket.disconnect()
  }
}

protocol WebSocketManagerDelegate: AnyObject {
  func receiveServerMessage(message: String)
}
