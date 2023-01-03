//
//  LocationsResponse.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/01/23.
//

import Foundation

struct LocationsResponse: Codable {
    
    let info: Info?
    let results: [Location]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }
}
