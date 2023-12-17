//
//  ListsModel.swift
//  BookStore
//
//  Created by Admin on 16.12.2023.
//

import Foundation

struct ListModel{
    let name: String
    let books: [Book]
}

struct SourceLists{
    static func getLists() -> [ListModel] {
        [
//            ListModel(name: "Reading List"),
//            ListModel(name: "Want to read"),
        ]
    }
}
