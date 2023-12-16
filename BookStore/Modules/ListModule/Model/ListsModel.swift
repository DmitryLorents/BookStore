//
//  ListsModel.swift
//  BookStore
//
//  Created by Admin on 16.12.2023.
//

import Foundation

struct ListsModel{
    let name: String
}

struct SourceLists{
    static func getLists() -> [ListsModel] {
        [
            ListsModel(name: "Reading List"),
            ListsModel(name: "Want to read"),
        ]
    }
}
