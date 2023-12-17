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
        CustomData(title: "Science", backgroundImage: "bookCovers3"),
        CustomData(title: "Fiction", backgroundImage: "bookCovers4"),
        CustomData(title: "History", backgroundImage: "bookCovers1"),
        CustomData(title: "Military", backgroundImage: "bookCovers2"),
        CustomData(title: "Health", backgroundImage: "bookCovers3"),
        CustomData(title: "Biography", backgroundImage: "bookCovers4"),
        CustomData(title: "Children", backgroundImage: "bookCovers1"),
        CustomData(title: "Fantasy", backgroundImage: "bookCovers2"),
        CustomData(title: "Horror", backgroundImage: "bookCovers3"),
        CustomData(title: "Thriller", backgroundImage: "bookCovers4"),
    ]
}

struct APICategoryModel: Codable {
    let cats: [Work]
}

struct Work: Codable {
    let key: String
    let title: String
    let coverId: Int
    let editionCount: Int
    let authors: [Author]
    let firstPublishYear: Int

    struct Author: Codable {
        let name: String
        let key: String
    }
}

public struct CategoryCollection: Codable {
    let key: String
    let name: String
    let workCount: Int
    let works: [Work]
}
