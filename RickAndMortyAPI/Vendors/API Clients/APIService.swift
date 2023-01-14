//
//  APIService.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import Foundation

/// Primary API service object to get data
final class APIService {
    
    /// Shared singleton instance
    static let shared = APIService()
    
    private let cacheManager = APICacheManager()
    
    /// Privatized constructor
    private init() {}
    
    /// Send API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    func execute<S: Codable>(_ request: APIRequest, expecting type: S.Type, completion: @escaping (Result<S, Error>) -> Void) {
        
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
            
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(APIServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIServiceError.failedToGetData))
                return
            }
            
            // Decode the response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from request: APIRequest) -> URLRequest? {
        
        guard let url = request.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        
        return request
    }
}
