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
    
    convenience init?(url: URL) {
        
        let string = url.absoluteString
        if !string.contains(Constants.BASE_URL) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.BASE_URL + "/", with: "")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let apiEndpoint = APIEndpoint(rawValue: endpointString) {
                    self.init(endpoint: apiEndpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap { string in
                    
                    guard string.contains("=") else {
                        return nil
                    }
                    
                    let parts = string.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                }
                if let apiEndpoint = APIEndpoint(rawValue: endpointString) {
                    self.init(endpoint: apiEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        
        return nil
    }
}

extension APIRequest {
    
    static let listCharactersRequests = APIRequest(
        endpoint: .character,
        queryParameters: [
            URLQueryItem(name: "page", value: "1")
        ])
}
