//
//  SearchInputViewVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import Foundation

final class SearchInputViewVM {
    
    private let type: SearchVC.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var choices: [String] {
            switch self {
                case .status:
                    return ["Alive", "Dead", "Unknown"]
                    
                case .gender:
                    return ["Male", "Female", "Genderless", "Unknown"]
                    
                case .locationType:
                    return ["Cluster", "Planer", "Microverse"]
            }
        }
    }
    
    init(type: SearchVC.Config.`Type`) {
        self.type = type
    }
    
    public var hasDynamicOptions: Bool {
        
        switch self.type {
            case .character, .location:
                return true
            case .episode:
                return  false
        }
    }
    
    public var options: [DynamicOption] {
        
        switch self.type {
            case .character:
                return [.status, .gender]
            case .location:
                return [.locationType]
            case .episode:
                return []
            }
    }
    
    public var searchPlaceholderText: String {
        
            switch self.type {
            case .character:
                return "Character Name"
            case .location:
                return "Location Name"
            case .episode:
                return "Episode Title"
            }
    }
}
