//
//  ProductCollectionViewCell.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var price: UILabel!
    @IBOutlet weak private var desc: UILabel!
    
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    func configureCell(_ model: Product, isList: Bool) {
        image.image = UIImage(data: model.image)
        title.text = model.title
        price.text = model.price
        desc.text = model.description
        desc.isHidden = !isList
        imageWidthConstraint.constant = isList ? 100 : 70
    }
}


