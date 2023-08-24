//
//  Category.swift
//  E-Store
//
//  Created by Laptop MCO on 09/08/23.
//

import Foundation

struct Category {
    let id: Int
    let name: String
    let image: String
}

extension Category: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(id, forKey: .id)
//        try container.encodeIfPresent(name, forKey: .name)
//        try container.encodeIfPresent(image, forKey: .image)
//    }
    
}
