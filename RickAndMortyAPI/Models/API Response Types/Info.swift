//
//  Info.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/01/23.
//

import Foundation

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
