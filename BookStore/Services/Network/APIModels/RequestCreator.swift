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

struct OpenLibraryEndpoints {
    private let host: String
    private let path: String
    private let queryItems: [URLQueryItem]
    private var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = ["/",path].joined()
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            preconditionFailure("Unable to create url from: \(components)")
        }
        return url
    }
    
    private init(host: String = "openlibrary.org",
                 path: String,
                 queryItems: [URLQueryItem] = .init()
    ) {
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
    
    func request(_ payload: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpBody = payload
        return request
    }
    
    static func home(limit: Int = 30) -> Self {
        .init(path: "search.json",
              queryItems: [
                .init(name: "/mode", value: "everything"),
                .init(name: "q", value: "top"),
                .init(name: "sort", value: "rating"),
                .init(name: "limit", value: limit.description)
              ])
    }
    
    static func search(_ query: String, limit: Int = 10) -> Self {
        .init(path: "search.json",
              queryItems: [
                .init(name: "q", value: query),
                .init(name: "limit", value: limit.description)
              ])
    }
    
    static func info(key: String) -> Self {
        .init(path: "\(key).json")
    }
    
    static func image(_ bookID: Int) -> URL {
        self.init(host: "covers.openlibrary.org", path: "b/id/\(bookID)-M.jpg").url
    }
    
    static func returnDescriptionURL(key: String) -> URL {
        return self.init(host: "openlibrary.org", path: key).url
    }
    
    static func weelky() -> Self {
        return self.init(path: "trending/weekly.json")
    }
    
    static func monthly() -> Self {
        return self.init(path: "trending/monthly.json")
    }
    
    static func yearly() -> Self {
        return self.init(path: "trending/yearly.json")
    }
    
}
