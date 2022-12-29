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

struct Info: Codable {
    
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
}
