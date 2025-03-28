//
//  TargetType.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

/// A protocol representing a network request.
protocol TargetType: URLRequestConvertible {
    /// The base URL of the request.
    var baseUrl: URL { get }

    /// The path component of the request URL.
    var path: String { get }

    /// The HTTP method of the request.
    var method: HttpMethod { get }

    /// The query parameters of the request.
    var queryParameters: [String: String] { get }

    /// The body parameters of the request.
    var bodyParameters: [String: Any] { get }

    /// The headers of the request.
    var headers: [String: String] { get }
}

extension TargetType {
    /// Default implementation of headers.
    var headers: [String: String] { [:] }

    /// Default implementation of query parameters.
    var queryParameters: [String: String] { [:] }

    /// Default implementation of body parameters.
    var bodyParameters: [String: Any] { [:] }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
