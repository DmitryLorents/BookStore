//
//  ListModelData.swift
//  BookStore
//
//  Created by Admin on 17.12.2023.
//

import Foundation
import RealmSwift

final class ListModelData: Object {
    @Persisted var name: String
    @Persisted var books: List<BookModelData>

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
