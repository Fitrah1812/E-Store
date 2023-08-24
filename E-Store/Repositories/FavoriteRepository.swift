//
//  FavoriteRepository.swift
//  E-Store
//
//  Created by Laptop MCO on 11/08/23.
//

import Foundation
import UIKit
import CoreData

extension Notification.Name {
    static let favoriteAdded = NSNotification.Name("kFavoriteAdded")
}

class FavoriteRepository {
    static let shared: FavoriteRepository = FavoriteRepository()
    private init() { }
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveFavorite(_ product: Product) {
        let request = ProductData.fetchRequest()
        request.predicate = NSPredicate(format: "productId == \(product.id)")
        
        let productData: ProductData
        if let data = try? context.fetch(request).first {
            productData = data
        } else {
            productData = ProductData(context: context)
        }
        
        productData.productId = Int64(product.id)
        productData.title = product.title
        productData.desc = product.description
        productData.price = product.price
        if let category = product.category {
            productData.category = try? JSONEncoder().encode(category)
        }
        productData.images = try? JSONEncoder().encode(product.images)
        
        NotificationCenter.default.post(name: .favoriteAdded, object: nil)
        
        try? context.save()
    }
    
    func fetchFavorites() -> [Product] {
        let request = ProductData.fetchRequest()
        let datas = (try? context.fetch(request)) ?? []
        return datas.compactMap { Product(data: $0) }
        
//        datas.compactMap { data in
//            Product(data: data)
//        }
    }
    
    func deleteFavorite(productId: Int){
        let request = ProductData.fetchRequest()
        request.predicate = NSPredicate(format: "productId = \(productId)")
        if let data = try? context.fetch(request).first {
            context.delete(data)
            try? context.save()
        }
    }
}
