//
//  SettingsVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import UIKit

/// Controller to show app options and settings
final class SettingsVC: UIViewController {

    // MARK: - Properties
    private let viewModel = SettingsVM(cellViewModels: SettingsOptions.allCases.compactMap({ option in
        return SettingsCellVM(type: option)
    }))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        self.title = "Settings"
        view.backgroundColor = .systemBackground 
    }
}
