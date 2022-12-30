//
//  TabViewController.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import UIKit

/// Controller to house tabs and root VCs
final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTabs()
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        
        if #available(iOS 13.0, *) {
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithTransparentBackground()
            tabBarAppearance.backgroundColor = .systemBackground
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().selectedImageTintColor = .systemPink
        }
    }
    
    private func setupTabs() {
        
        let characterListVC = CharacterListVC()
        let locationListVC = LocationListVC()
        let episodeListVC = EpisodeListVC()
        let settingsVC = SettingsVC()
        
        for vc in [characterListVC, locationListVC, episodeListVC, settingsVC] {
            vc.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        let nav1 = UINavigationController(rootViewController: characterListVC)
        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        
        let nav2 = UINavigationController(rootViewController: locationListVC)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        
        let nav3 = UINavigationController(rootViewController: episodeListVC)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        
        let nav4 = UINavigationController(rootViewController: settingsVC)
        nav4.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "gear"), tag: 4)
        
        let navigationVC = [nav1, nav2, nav3, nav4]
        
        for nav in navigationVC {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(navigationVC, animated: true)
    }
}

