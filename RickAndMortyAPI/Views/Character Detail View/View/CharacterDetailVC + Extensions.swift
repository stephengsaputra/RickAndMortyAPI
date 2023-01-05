//
//  CharacterDetailVC + Extensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 05/01/23.
//

import Foundation
import UIKit

extension CharacterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .systemYellow
        case 1:
            cell.backgroundColor = .systemPink
        default:
            cell.backgroundColor = .systemPurple
        }
        
        return cell
    }
    
    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let sectionType = viewModel.sections
        switch sectionType[sectionIndex] {
            case .photo:
                return createPhotoSectionLayout()
            case .information:
                return createInformationSectionLayout()
            case .episodes:
                return createEpisodesSectionLayout()
        }
    }
    
    private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createInformationSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

