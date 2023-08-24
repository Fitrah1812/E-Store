//
//  Product.swift
//  E-Store
//
//  Created by Laptop MCO on 10/08/23.
//

import Foundation

// MARK: - ProductElement
struct Product {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category?
    let images: [String]
    
    init(data: ProductData){
        self.id = Int(data.productId)
        self.title = data.title ?? ""
        self.price = data.price
        self.description = data.desc ?? ""
        if let cat = data.category {
            self.category = try? JSONDecoder().decode(Category.self, from: cat)
        } else {
            self.category = nil
        }
        if let img = data.images {
            self.images = (try? JSONDecoder().decode([String].self, from: img)) ?? []
        } else {
            self.images = []
        }
        
    }
}

extension Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case images
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        category = try container.decodeIfPresent(Category.self, forKey: .category)
        images = try container.decodeIfPresent([String].self, forKey: .images) ?? []
    }
}


