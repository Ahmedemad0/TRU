//
//  ProductDetailsViewController.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: ProductDetailsViewModelProtocol
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    // MARK: - Init
    
    init(viewModel: ProductDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetails(model: viewModel.product)
    }

    // MARK: - Methods
    
    func configureDetails(model: Product) {
        imageView.image = UIImage(data: model.image)
        titleLabel.text = model.title
        price.text = model.price
        category.text = model.category
        descLabel.text = model.description
    }
}
