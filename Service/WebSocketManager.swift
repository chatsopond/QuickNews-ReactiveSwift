//
//  WebSocketManager.swift
//  QuickNews-ReactiveSwift
//
//  Created by Chatsopon Deepateep on 22/3/23.
//

import Foundation
import Starscream

/// WebSocketManager is a class to manage WebSocket connections
/// using the Starscream library. It handles connection, disconnection,
/// and reconnection logic, and delegates received messages to a delegate.
class WebSocketManager: WebSocketDelegate {
  /// The WebSocket instance used for the connection.
  // swiftlint:disable:next implicitly_unwrapped_optional
  var socket: WebSocket!

  /// A timer to manage reconnect attempts.
  private var reconnectTimer: Timer?

  /// A delegate to receive server messages.
  weak var delegate: WebSocketManagerDelegate?

  /// Initializes the WebSocketManager and initiates the connection.
  init() {
    reconnect()
  }

  /// Disconnects the WebSocket and invalidates the reconnect timer.
  func disconnect() {
    reconnectTimer?.invalidate()
    reconnectTimer = nil
    socket.disconnect()
  }

  /// Connects to the WebSocket server.
  private func reconnect() {
    // swiftlint:disable:next force_unwrapping
    let request = URLRequest(url: URL(string: "ws://localhost:8080")!)
    socket = WebSocket(request: request)
    socket.delegate = self
    socket.connect()
  }

  /// Schedules a reconnect attempt after a delay.
  private func scheduleReconnect() {
    guard reconnectTimer == nil else { return }

    reconnectTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
      guard let self = self else { return }
      self.reconnect()
    }
  }

  // MARK: - WebSocketDelegate

  /// Handles WebSocket events and delegates received messages to the delegate.
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

  // MARK: - WebSocket Actions

  /// Sends a text message to the WebSocket server.
  func sendTextMessage(_ message: String) {
    socket.write(string: message)
  }

  /// Sends binary data to the WebSocket server.
  func sendBinaryMessage(_ data: Data) {
    socket.write(data: data)
  }
}

/// A delegate protocol to handle received server messages.
protocol WebSocketManagerDelegate: AnyObject {
  /// This method is called when the WebSocketManager receives a server message.
  /// - Parameter message: The message received from the server as a String.
  func receiveServerMessage(message: String)
}
