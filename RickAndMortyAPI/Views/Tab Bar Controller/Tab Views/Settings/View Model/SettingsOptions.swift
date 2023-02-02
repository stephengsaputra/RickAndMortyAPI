//
//  SettingsOptions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 02/02/23.
//

import UIKit

enum SettingsOptions: CaseIterable {
    
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var displayTitle: String {
        
        switch self {
            case .rateApp:
                return "Rate App"
            case .contactUs:
                return "Contact Us"
            case .terms:
                return "Terms of Service"
            case .privacy:
                return "Privacy Policy"
            case .apiReference:
                return "API Reference"
            case .viewSeries:
                return "View Video Series"
            case .viewCode:
                return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
        
        switch self {
            case .rateApp:
                return .systemBlue
            case .contactUs:
                return .systemGreen
            case .terms:
                return .systemRed
            case .privacy:
                return .systemYellow
            case .apiReference:
                return .systemOrange
            case .viewSeries:
                return .systemCyan
            case .viewCode:
                return .systemPink
            }
    }
    
    var iconImage: UIImage? {
        
        switch self {
            case .rateApp:
                return UIImage(systemName: "star.fill")
            case .contactUs:
                return UIImage(systemName: "paperplane")
            case .terms:
                return UIImage(systemName: "doc")
            case .privacy:
                return UIImage(systemName: "lock")
            case .apiReference:
                return UIImage(systemName: "list.clipboard")
            case .viewSeries:
                return UIImage(systemName: "tv.fill")
            case .viewCode:
                return UIImage(systemName: "hammer.fill")
        }
    }
    
    var targetURL: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://github.com/stephengsaputra")
        case .terms:
            return URL(string: "https://github.com/stephengsaputra")
        case .privacy:
            return URL(string: "https://github.com/stephengsaputra")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/playlist?list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/stephengsaputra/RickAndMortyAPI")
        }
    }
}
