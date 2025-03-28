//
//  ProductsListUseCases.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

class ProductsListUseCases: ProductsListUseCasesProtocol {
    
    @Inject var repo: ProductsListRepositoryProtocol

    func getProductsList() async throws -> Products {
        do {
            return try await repo.getProductsList()
        } catch {
            throw error
        }
       
    }
}
