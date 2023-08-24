//
//  Profile.swift
//  E-Store
//
//  Created by Laptop MCO on 16/08/23.
//

import Foundation

struct Profile: Codable {
    let id: Int
    let email: String
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case avatar
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(name, forKey: .name)
        try container.encode(avatar, forKey: .avatar)
    }
}
