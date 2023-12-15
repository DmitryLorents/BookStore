//
//  APIBookModel.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

struct APIBookModel: Codable, Sendable {
    
    struct Description: Codable {
        let value: String?
    }
    
    let description: String?
}
