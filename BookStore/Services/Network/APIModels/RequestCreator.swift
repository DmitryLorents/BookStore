//
//  RequestCreator.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

enum APIRequest {
    case home
    case search(String)
    case image(Int)
    case bookInfo(String)
}

struct RequestCreator {
    enum ImageSize: String {
        case small = "-S.jpg"
        case medium = "-M.jpg"
        case large = "-L.jpg"
    }
    
    private enum RequestType: String {
        case home = "https://openlibrary.org/search.json?/mode=everything&q=top&sort=rating"
        case search = "https://openlibrary.org/search.json?"
        case image = "https://covers.openlibrary.org/b/id/"
        case bookInfo = "https://openlibrary.org/works/"
    }
    
    func createRequest(_ request: APIRequest) -> String {
        switch request {
        case .home:
            RequestType.home.rawValue
        case .search(let text):
            RequestType.search.rawValue + text.trimmingCharacters(in: .symbols)
        case .image(let idetifier):
            RequestType.image.rawValue + String(idetifier) + ImageSize.medium.rawValue
        case .bookInfo(let bookID):
            RequestType.bookInfo.rawValue + bookID + ".json"
        }
    }
    
//    func createSearchRequest(with body: String) -> String {
//        RequestType.search.rawValue + body.trimmingCharacters(in: .symbols)
//    }
//    
//    func createImageRequest(with body: String) -> String {
//        RequestType.image.rawValue + body + ImageSize.medium.rawValue
//    }
//    
//    func createBookRequest(with body: String) -> String {
//        RequestType.bookInfo.rawValue + body + ".json"
//    }
//    
//    func createMainBooksRequest(_ : String = "") -> String {
//        RequestType.home.rawValue
//    }

}
