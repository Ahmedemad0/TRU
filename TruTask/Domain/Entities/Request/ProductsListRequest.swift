//
//  ProductsListRequest.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

struct ProductsListRequest: RequestType {
    typealias ResponseType = ProductsResponse

    var baseUrl: URL { Constants.baseURL }
    var path: String { "/products" }
    var method: HttpMethod = .get
    var queryParameters: [String: String] {
        ["limit" : "7"]
    }

    let responseDecoder: (Data) throws -> ProductsResponse = { data in
        
        try JSONDecoder().decode(ResponseType.self, from: data)
    }
}
