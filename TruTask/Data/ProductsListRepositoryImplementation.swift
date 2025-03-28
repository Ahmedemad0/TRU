//
//  ProductsListRepositoryImplementation.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

final class ProductsListRepositoryImplementation:  ProductsListRepositoryProtocol {
    
    @Inject var networking: NetworkDispatcher
    
    func getProductsList() async throws -> Products {
        do {
            
            let request = ProductsListRequest()
            let data = try await self.networking.dispatch(request)
            let products = await self.mapProductsResponseIntoProducts(data)
            return products
            
        } catch {
            throw error
        }
    }
    
    
    private func mapProductsResponseIntoProducts(_ model: ProductsResponse) async -> Products {
        var products: Products = []
        for product in model {
            let imageData: Data
            
            do {
                imageData = try await product.image.fetchData()
            } catch {
                imageData = Data()
            }
            
            let mappedProduct = Product(
                id: product.id,
                title: product.title,
                description: product.description,
                price: "\(product.price) EGP",
                category: product.category,
                image: imageData
            )
            products.append(mappedProduct)
        }
        return products
    }
}
