//
//  ProductsListViewModel.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation
import Combine

protocol ProductsListViewModelProtocol {
    var products: Products { get }
    var productSelectedPublisher: AnyPublisher<Int, Never> { get }
    var isListPublisher: AnyPublisher<Bool, Never> { get }
    
    func didSelectProduct(_ index: Int)
    func didChangeListOrGrid()
    func isList() -> Bool
}


class ProductsListViewModel: ProductsListViewModelProtocol {
    
    @Published var products: Products = []
    
    private let productSelectedSubject = PassthroughSubject<Int, Never>()
    var productSelectedPublisher: AnyPublisher<Int, Never> {
        return productSelectedSubject.eraseToAnyPublisher()
    }
    
    private let isListSubject = CurrentValueSubject<Bool, Never>(true)
    var isListPublisher: AnyPublisher<Bool, Never> {
        return isListSubject.eraseToAnyPublisher()
    }
        
    init() {
        getProducts()
    }

    private func getProducts() {
        products = [
            Product(id: 0, title: "TITLE 1", description: "Desc 1", price: "123", image: Data()),
            Product(id: 1, title: "TITLE 2", description: "Desc 2", price: "123", image: Data()),
            Product(id: 2, title: "TITLE 3", description: "Desc 3", price: "123", image: Data()),
            Product(id: 3, title: "TITLE 4", description: "Desc 4", price: "123", image: Data()),
        ]
    }
    
    func didSelectProduct(_ index: Int) {
        productSelectedSubject.send(index)
    }
    
    func didChangeListOrGrid() {
        isListSubject.send(!isListSubject.value)
    }

    func isList() -> Bool {
        isListSubject.value
    }
}
