//
//  ProductsResponse.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
}

typealias ProductsResponse = [ProductResponse]
