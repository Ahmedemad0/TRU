//
//  ProductsListRepositoryImplementation.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

final class ProductsListRepositoryImplementation:  ProductsListRepositoryProtocol {
    
    @Inject var networking: NetworkDispatcher
    let context = PersistenceService.shared.persistentContainer
    
    
    func getProductsList() async throws -> Products {
        do {
            
            let request = ProductsListRequest()
            let data = try await self.networking.dispatch(request)
            let products = await self.mapProductsResponseIntoProducts(data)
            cacheProducts(products)
            return products
            
        } catch {
            return cachedProducts()
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
    
    private func cachedProducts() -> Products {
        
        var products: Products = []
        if let localProducts: [ProductsItem] = PersistenceService.shared.fetchObjects(ofType: ProductsItem.self) {
            for product in localProducts {
                let mappedProduct = Product(
                    id: Int(product.productId ?? "0") ?? 0,
                    title: product.title ?? "",
                    description: product.desc ?? "",
                    price: product.price ?? "",
                    category: product.category ?? "",
                    image: product.image ?? Data()
                )
                products.append(mappedProduct)
            }
        }
        return products
    }
    
    private func cacheProducts(_ products: Products) {
        
        PersistenceService.shared.deleteAllData()
        
        for product in products {
            let localProduct: ProductsItem = PersistenceService.shared.createObject(ofType: ProductsItem.self)
            localProduct.productId =  "\(product.id)"
            localProduct.title = product.title
            localProduct.desc = product.description
            localProduct.price = product.price
            localProduct.category = product.category
            localProduct.image = product.image
            PersistenceService.shared.saveContext()
        }
    }
}
