//
//  ResultsModel.swift
//

import Foundation

struct CustomData: Codable {
    var title: String
    var backgroundImage: String
}

struct CategoriesModel {
    static let data = [
        CustomData(title: "Drama", backgroundImage: "bookCovers"),
        CustomData(title: "Comedy", backgroundImage: "bookCovers"),
        CustomData(title: "Science", backgroundImage: "bookCovers"),
        CustomData(title: "Fantasy", backgroundImage: "bookCovers"),
        CustomData(title: "Fiction", backgroundImage: "bookCovers"),
        CustomData(title: "Military", backgroundImage: "bookCovers"),
        CustomData(title: "Drama", backgroundImage: "bookCovers"),
        CustomData(title: "Comedy", backgroundImage: "bookCovers"),
        CustomData(title: "Science", backgroundImage: "bookCovers"),
        CustomData(title: "Fantasy", backgroundImage: "bookCovers"),
        CustomData(title: "Fiction", backgroundImage: "bookCovers"),
        CustomData(title: "Military", backgroundImage: "bookCovers"),
    ]
}
