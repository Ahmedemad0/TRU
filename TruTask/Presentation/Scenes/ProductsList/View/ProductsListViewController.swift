//
//  ProductsListViewController.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import UIKit
import Combine

class ProductsListViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: ProductsListViewModelProtocol
    // custom data source and delegate for the collection view.
    private var dataSources: ProductsListCollectionViewDataSources?
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Outlets

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: - Init
    
    init(viewModel: ProductsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        registerCell()
        createDataSource()
        setCollectionViewDelegates()
    }
    
    // MARK: - Methods
    
    private func registerCell(){
        collectionView.register(cells: [ProductCollectionViewCell.self])
    }
    
    private func createDataSource() {
        dataSources = ProductsListCollectionViewDataSources(viewModel)
    }
    
    // Set the collection view's data source and delegate.
    private func setCollectionViewDelegates() {
        collectionView.dataSource = dataSources
        collectionView.delegate = dataSources
    }
    
    private func subscriptions() {
        subscribeProductsListViewModel()
        subscribeSelectIndex()
        subscribeIsList()
    }
    
    private func subscribeSelectIndex() {
        viewModel.productSelectedPublisher
        .sink { [weak self] index in
            guard let self else { return }
            self.navigateIntoDetails(at: index)
        }
        .store(in: &cancellables)
    }
    
    private func subscribeIsList() {
        viewModel.isListPublisher
        .sink { [weak self] index in
            guard let self else { return }
            self.collectionView.reloadData()
        }
        .store(in: &cancellables)
    }
    
    func subscribeProductsListViewModel() {
        viewModel.productsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func navigateIntoDetails(at index: Int) {
        let productDetailsViewController = ProductDetailsViewController(viewModel: ProductDetailsViewModel(product: viewModel.products()[index]))
        navigationController?.pushViewController(productDetailsViewController, animated: true)
    }

    // MARK: - Actions
    
    @IBAction func listOrGridButtonTapped(_ sender: UIButton) {
        viewModel.didChangeListOrGrid()
    }
    
}
