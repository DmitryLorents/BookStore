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
    static func getCart() ->[CartModel] {
        [
            .init(imageBook: UIImage(named: "bookСover")!, nameBook: "Book", authorBook: "Author", genreBook: "Genre"),
            .init(imageBook: UIImage(named: "bookСover")!, nameBook: "Book", authorBook: "Author", genreBook: "Genre"),
        ]
    }
}
