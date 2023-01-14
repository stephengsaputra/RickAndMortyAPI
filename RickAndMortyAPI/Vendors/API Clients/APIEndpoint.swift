//
//  APIEndpoint.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import Foundation

/// Represents unique API endpoints
@frozen enum APIEndpoint: String, Hashable, CaseIterable {
    case character
    case location
    case episode
}
