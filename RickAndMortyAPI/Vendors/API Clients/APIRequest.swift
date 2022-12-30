//
//  APIRequest.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import Foundation

/// Object that represents a single API call
final class APIRequest {
    
    /// API Constants
    private struct Constants {

        /// Base URL
        static let BASE_URL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: APIEndpoint
    
    /// Path components for API (IF ANY!)
    private let pathComponents: [String]
    
    /// Query parameters for API (IF ANY!)
    private let queryParameters: [URLQueryItem]
    
    /// Constructed URL for API request in String format
    private var urlString: String {
        
        var string = Constants.BASE_URL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Computed and constructed API URL
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired HTTP method
    public let httpMethod = "GET"
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: An array of path components
    ///   - queryItems: An array of query parameters
    init(endpoint: APIEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension APIRequest {
    
    static let listCharactersRequests = APIRequest(
        endpoint: .character,
        queryParameters: [
            URLQueryItem(name: "page", value: "1")
        ])
}
