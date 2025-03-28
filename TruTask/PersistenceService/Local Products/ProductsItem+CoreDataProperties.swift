//
//  ProductsItem+CoreDataProperties.swift
//  TruTask
//
//  Created by Ahmed Emad on 28/03/2025.
//
//

import Foundation
import CoreData


extension ProductsItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsItem> {
        return NSFetchRequest<ProductsItem>(entityName: "ProductsItem")
    }
    
    @NSManaged public var productId: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var price: String?
    @NSManaged public var category: String?
    @NSManaged public var image: Data?

}

extension ProductsItem : Identifiable {

}
