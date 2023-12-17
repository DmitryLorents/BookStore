//
//  APISearchModel.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

struct APISearchModel: Codable {
    let docs: [Doc]
}

struct Doc: Codable {
    let key: String?
    let title: String?
    let authorName: [String]?
    let subjectFacet: [String]? // category
    let ratingsAverage: Double? // several rating
    let ratingsSortable: Double? // rating in API
    let coverI: Int? // image ID
    let isbn: [String]? // If coverI is empty, check this number
}
