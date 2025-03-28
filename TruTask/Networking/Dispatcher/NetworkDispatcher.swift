//
//  NetworkDispatcher.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

/// A protocol for dispatching network requests.
protocol NetworkDispatcher {
    /// Dispatches a network request and returns the response asynchronously.
    /// - Parameters:
    ///   - request: The network request to dispatch.
    /// - Returns: The response from the network request.
    func dispatch<Request: RequestType>(_ request: Request) async throws -> Request.ResponseType
}
