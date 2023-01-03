//
//  APIServiceError.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation

/// Represents the errors that could happen when fetching
enum APIServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
}
