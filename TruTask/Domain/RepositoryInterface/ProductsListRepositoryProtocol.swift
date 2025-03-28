//
//  ProductsListRepositoryProtocol.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

protocol ProductsListRepositoryProtocol {
    func getProductsList() async throws -> Products
}
