//
//  EpisodesResposne.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/01/23.
//

import Foundation

struct EpisodesResponse: Codable {
    
    let info: Info?
    let results: [Episode]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }
}
