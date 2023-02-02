//
//  SettingsCellVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 02/02/23.
//

import UIKit

struct SettingsCellVM: Identifiable {
    
    let id = UUID()
    let type: SettingsOptions
    let onTapHandler: (SettingsOptions) -> Void
    
    init(type: SettingsOptions, onTapHandler: @escaping (SettingsOptions) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
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
