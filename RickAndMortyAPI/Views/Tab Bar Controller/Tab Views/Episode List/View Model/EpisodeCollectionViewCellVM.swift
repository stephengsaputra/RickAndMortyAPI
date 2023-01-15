//
//  EpisodeCollectionViewCellVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 15/01/23.
//

import Foundation

final class EpisodeCollectionViewCellVM: Hashable, Equatable {
    
    let episodeName: String
    let episodeSeason: String
    let episodeAirDate: String
    
    init(episodeName: String, episodeSeasion: String, episodeAirDate: String) {
        self.episodeName = episodeName
        self.episodeSeason = episodeSeasion
        self.episodeAirDate = episodeAirDate
    }
    
    // MARK: - Hashable
    static func == (lhs: EpisodeCollectionViewCellVM, rhs: EpisodeCollectionViewCellVM) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(episodeSeason)
        hasher.combine(episodeName)
        hasher.combine(episodeAirDate)
    }
}
