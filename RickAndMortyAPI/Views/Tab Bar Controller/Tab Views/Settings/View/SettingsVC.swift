//
//  SettingsVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import UIKit
import SwiftUI
import SafariServices
import StoreKit

/// Controller to show app options and settings
final class SettingsVC: UIViewController {

    // MARK: - Properties
    private var settingsView: UIHostingController<SettingsView>?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    private func handleTap(option: SettingsOptions) {
        
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetURL {
            
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true)
        } else if option == .rateApp {
            
            if let windowScene = self.view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
                
            }
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        self.title = "Settings"
        view.backgroundColor = .systemBackground
        
        let settingsView = UIHostingController(
            rootView: SettingsView(
                viewModel: SettingsVM(
                    cellViewModels: SettingsOptions.allCases.compactMap({ option in
                        return SettingsCellVM(type: option) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                }))
            )
        )
        
        self.addChild(settingsView)
        settingsView.didMove(toParent: self)
        
        view.addSubview(settingsView.view)
        settingsView.view.translatesAutoresizingMaskIntoConstraints = false
        settingsView.view.backgroundColor = .clear
        NSLayoutConstraint.activate([
            settingsView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsView.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsView.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}
