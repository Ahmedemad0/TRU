//
//  ProductsListViewModel.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import Foundation
import Combine

protocol ProductsListViewModelProtocol {
    var productsPublisher: AnyPublisher<Products, Never> { get }
    var productSelectedPublisher: AnyPublisher<Int, Never> { get }
    var isListPublisher: AnyPublisher<Bool, Never> { get }
    
    func products() -> Products
    func didSelectProduct(_ index: Int)
    func didChangeListOrGrid()
    func isList() -> Bool
}


class ProductsListViewModel: ProductsListViewModelProtocol {
    
    @Inject var useCases: ProductsListUseCasesProtocol
    
    private let productsSubject = CurrentValueSubject<Products, Never>([])
    var productsPublisher: AnyPublisher<Products, Never> {
        return productsSubject.eraseToAnyPublisher()
    }
    
    private let productSelectedSubject = PassthroughSubject<Int, Never>()
    var productSelectedPublisher: AnyPublisher<Int, Never> {
        return productSelectedSubject.eraseToAnyPublisher()
    }
    
    private let isListSubject = CurrentValueSubject<Bool, Never>(true)
    var isListPublisher: AnyPublisher<Bool, Never> {
        return isListSubject.eraseToAnyPublisher()
    }
        
    init() {
        Task {
            await getProducts()
        }
    }

    private func getProducts() async {
        do {
            let products = try await useCases.getProductsList()
            productsSubject.send(products)
        } catch {
            debugPrint("ERROR: \(error.localizedDescription)")
        }
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
    
    func products() -> Products {
        productsSubject.value
    }
}
