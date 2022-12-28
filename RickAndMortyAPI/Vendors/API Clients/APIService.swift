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
    
    /// Privatized constructor
    private init() {}
    
    /// Send API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    func execute<S: Codable>(
        _ request: APIRequest,
        expecting type: S.Type,
        completion: @escaping (Result<S, Error>) -> Void) {
        
        
    }
}
