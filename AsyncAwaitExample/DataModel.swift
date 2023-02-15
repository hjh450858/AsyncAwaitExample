//
//  DataModel.swift
//  AsyncAwaitExample
//
//  Created by 황재현 on 2023/02/15.
//

import Foundation

struct DataModel: Codable {
    let page, perPage, total, totalPages: Int
    let data: [DataMT]
    let support: SupportM
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

struct DataMT: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}


struct SupportM: Codable {
    let url: String
    let text: String
}
