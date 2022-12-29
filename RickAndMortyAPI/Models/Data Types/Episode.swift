//
//  Episode.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import Foundation

struct Episode: Codable {
    
    let id: Int?
    let name: String?
    let airDate: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case airDate = "air_date"
        case episode = "episode"
        case characters = "characters"
        case url = "url"
        case created = "created"
    }
}
