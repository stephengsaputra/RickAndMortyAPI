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
    ///   - completion: Callback with data or error
    private func execute(_ request: APIRequest, completion: @escaping () -> Void) {
        
        
    }
}
