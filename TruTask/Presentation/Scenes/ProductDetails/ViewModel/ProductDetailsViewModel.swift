//
//  ProductDetailsViewModel.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
}
