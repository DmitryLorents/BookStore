//
//  BookModelData.swift
//  BookStore
//
//  Created by Admin on 13.12.2023.
//

import Foundation
import RealmSwift

final class BookModelData: Object {
    @Persisted var keyForServer: String
    @Persisted var name: String
    @Persisted var author: String
    @Persisted var category: String
    @Persisted var imageID: Int
    @Persisted var rating: Double
    @Persisted var isRecent: Bool = false
    
    convenience init(key: String, name: String, author: String, category: String, imageID: Int, rating: Double) {
        self.init()
        self.keyForServer = key
        self.name = name
        self.author = author
        self.category = category
        self.imageID = imageID
        self.rating = rating
    }
}
