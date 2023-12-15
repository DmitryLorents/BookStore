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
        CustomData(title: "Arts", backgroundImage: "bookCovers1"),
        CustomData(title: "Animals", backgroundImage: "bookCovers2"),
        CustomData(title: "Fiction", backgroundImage: "bookCovers3"),
        CustomData(title: "Love", backgroundImage: "bookCovers4"),
        CustomData(title: "Business", backgroundImage: "bookCovers1"),
        CustomData(title: "Children", backgroundImage: "bookCovers2"),
        CustomData(title: "History", backgroundImage: "bookCovers3"),
        CustomData(title: "Health", backgroundImage: "bookCovers4"),
        CustomData(title: "Biography", backgroundImage: "bookCovers1"),
        CustomData(title: "Sciences", backgroundImage: "bookCovers2"),
        CustomData(title: "Places", backgroundImage: "bookCovers3"),
        CustomData(title: "Military", backgroundImage: "bookCovers4"),
    ]
}
