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

struct APICategoryModel: Codable {
    let cats: [CategoryCollection.Work]
}


public struct CategoryCollection: Codable {
    let key: String
    let name: String
    let work_count: Int
    let works: [Work]

    struct Work: Codable {
        let key: String
        let title: String
        let cover_id: Int
//        let cover_edition_key: String?
//        let subject: [Subject] это если понадобятся ключевые слова по теме, нужна будет структурка Subject
        let edition_count: Int
        let authors: [Author]
        let first_publish_year: Int
        let has_fulltext: Bool //использовать при выгрузке в читалку?
//        let ia: String?

        struct Author: Codable {
            let name: String
            let key: String
        }
    }
}
