//
//  CharactersResponse.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation

struct CharactersResponse: Codable {
    
    let info: Info?
    let results: [Character]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }
}
