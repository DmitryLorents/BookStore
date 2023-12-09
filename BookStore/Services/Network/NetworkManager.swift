//
//  NetworkManager.swift
//  BookStore
//
//  Created by Максим Горячкин on 09.12.2023.
//

import Foundation

enum NetworkError: Error {
    case badURL, badRequest, badResponce, invalidData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Codable>(from url: String?, with complition: @escaping (Result<T, Error>) -> Void) {
        guard let stringURL = url, let url = URL(string: stringURL) else {
            complition(.failure(NetworkError.badURL))
            return
        }
            
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(decodeData))
                }
            } catch {
                complition(.failure(NetworkError.badRequest))
            }
        }.resume()
    }
    
    
    func fetchAsyncData<T: Codable>(from url: String) async throws -> Result<T, NetworkError> {
        guard let url = URL(string: url) else { return .failure(NetworkError.badURL) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodeData = try decoder.decode(T.self, from: data)
            return .success(decodeData)
        } catch {
            return .failure(NetworkError.invalidData)
        }
    }
    
    // MARK: - Section Of Adding Images to Stash or donwload it from Stash
    
    func saveDataToCache(with data: Data, and responce: URLResponse) {
        guard let url = responce.url else { return }
        let request = URLRequest(url: url)
        let cachedResponce = CachedURLResponse(response: responce, data: data)
        URLCache.shared.storeCachedResponse(cachedResponce, for: request)
    }
    
    func getDataFromCache(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponce = URLCache.shared.cachedResponse(for: request) {
            return cachedResponce.data
        } else {
            return nil
        }
    }
    
}
