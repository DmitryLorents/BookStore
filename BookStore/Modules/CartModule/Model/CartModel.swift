//
//  RainbowApp
//

import UIKit

struct CartModel{
    let imageBook: UIImage
    let nameBook: String
    let authorBook: String
    let genreBook: String
}

struct Source{
    static func getCart() ->[Book] {
        [
            Book(key: "key1", name: "name1", author: "author1", category: "category1", imageID: 1, rating: 3.3),
            Book(key: "key2", name: "name2", author: "author2", category: "category2", imageID: 2, rating: 5.0),
        ]
    }
}
