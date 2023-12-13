//
//  NetworkManager.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    
    private let decoder: JSONDecoder
    
    static let shared = NetworkManager()
    
    private init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchAsyncData<T: Decodable>(from endpoint: OpenLibraryEndpoints) async throws -> T {
        try await fetchAsyncData(from: endpoint.request())
    }
    
    private func fetchAsyncData<T: Decodable>(from request: URLRequest) async throws -> T {
        let data: Data
        
        switch getDataFromCache(from: request) {
        case .some(let cachedData):
            data = cachedData
        case .none:
            let (requestedData, response) = try await URLSession.shared.data(for: request)
            saveDataToCache(with: requestedData, and: response)
            data = requestedData
        }
        
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }

    
    // MARK: - Section Of Adding Images to Stash or donwload it from Stash
    
    private func saveDataToCache(with data: Data, and responce: URLResponse) {
        guard let url = responce.url else { return }
        let request = URLRequest(url: url)
        let cachedResponce = CachedURLResponse(response: responce, data: data)
        URLCache.shared.storeCachedResponse(cachedResponce, for: request)
    }
    
    private func getDataFromCache(from request: URLRequest) -> Data? {
        URLCache.shared.cachedResponse(for: request)?.data
    }
    
}
