//
//  CharacterDetailInformationVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 07/01/23.
//

import Foundation
import UIKit

final class CharacterDetailInformationVM {
    
    enum `Type` {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case totalEpisodesCount
        
        var tintColor: UIColor {
            
            switch self {
                case .status: return .systemRed
                case .gender: return .systemOrange
                case .type: return .systemYellow
                case .species: return .systemGreen
                case .origin: return .systemMint
                case .location: return .systemBlue
                case .created: return .systemPurple
                case .totalEpisodesCount: return .systemPink
            }
        }
        
        var iconImage: UIImage? {
            
            switch self {
                case .status: return UIImage(systemName: "figure.stand")
                case .gender: return UIImage(systemName: "person.text.rectangle.fill")
                case .type: return UIImage(systemName: "bell")
                case .species: return UIImage(systemName: "person.crop.circle.badge.questionmark.fill")
                case .origin: return UIImage(systemName: "globe")
                case .location: return UIImage(systemName: "location.north.circle.fill")
                case .created: return UIImage(systemName: "pencil.circle.fill")
                case .totalEpisodesCount: return UIImage(systemName: "display")
            }
        }
        
        var displayTitle: String {
            
            switch self {
                case .status: return "Status"
                case .gender: return "Gender"
                case .type: return "Type"
                case .species: return "Species"
                case .origin: return "Origin"
                case .location: return "Location"
                case .created: return "Created"
                case .totalEpisodesCount: return "Total Episodes"
            }
        }
    }
    
    private let type: `Type`
    private let value: String
    
    var title: String {
        return self.type.displayTitle
    }
    
    var displayValue: String {
       
        if value.isEmpty { return "None" }
        
        if let date = Self.dateFormatter.date(from: value), type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        
        return value
    }
    
    var displayImage: UIImage? {
        return self.type.iconImage
    }
    
    var tintColor: UIColor {
        return self.type.tintColor
    }
    
    init(type: `Type`, value: String) {
        self.type = type
        self.value = value
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
}
