//
//  Character.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import Foundation

struct Character: Codable {
    
    let id: Int?
    let name: String?
    let status: Status?
    let species: String?
    let type: String?
    let gender: Gender?
    let origin: Origin?
    let location: SingleLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case type = "type"
        case gender = "gender"
        case origin = "origin"
        case location = "location"
        case image = "image"
        case episode = "episode"
        case url = "url"
        case created = "created"
    }
}

struct Origin: Codable {
    
    let name: String
    let url: String
}

struct SingleLocation: Codable {
    
    let name: String
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "Unknown"
}
