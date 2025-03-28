//
//  Product.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation

struct Product {
    var id: Int
    var title: String
    var description: String
    var price: String
    var image: Data
}

typealias Products = [Product]
