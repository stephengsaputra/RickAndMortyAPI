//
//  SettingsCellVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 02/02/23.
//

import UIKit

struct SettingsCellVM: Identifiable, Hashable {
    
    let id = UUID()
    private let type: SettingsOptions
    
    init(type: SettingsOptions) {
        self.type = type
    }
    
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
