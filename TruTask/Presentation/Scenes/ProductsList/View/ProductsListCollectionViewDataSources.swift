//
//  ProductsListCollectionViewDataSources.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import UIKit

class ProductsListCollectionViewDataSources: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

    private let viewModel: ProductsListViewModelProtocol
    
    // Initializer that takes a view model as a parameter.
    init(_ viewModel: ProductsListViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as ProductCollectionViewCell
        cell.configureCell(viewModel.products()[indexPath.row], isList: viewModel.isList())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectProduct(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       // NOTE: I don't find pagination parameters with that endpoint
    }
}

extension ProductsListCollectionViewDataSources: UICollectionViewDelegateFlowLayout {
    // Defines the size for each item in the collection view.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = viewModel.isList() ? collectionView.frame.size.width : 180
        return CGSize(width: width , height: 120)
    }
}
