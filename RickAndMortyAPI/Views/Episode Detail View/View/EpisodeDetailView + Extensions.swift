//
//  EpisodeDetailView + Extensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 18/01/23.
//

import UIKit

extension EpisodeDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sections = viewModel?.cellViewModels else {
            return 0
        }
        
        let sectionType = sections[section]
        switch sectionType {
            case .information(let viewModels):
                return viewModels.count
            case .characters(let viewModels):
                return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let sections = viewModel?.cellViewModels else {
            fatalError("Fatal error!!")
        }
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
            case .information(let viewModels):
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeInfoCollectionViewCell.identifier, for: indexPath) as! EpisodeInfoCollectionViewCell
                cell.configure(with: viewModels[indexPath.row])
                
                return cell
            
            case .characters(let viewModels):
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
                cell.configure(with: viewModels[indexPath.row])
               
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        
        guard let sections = viewModel?.cellViewModels else {
            return createInfoLayout()
        }
        
        switch sections[section] {
        case .information:
            return createInfoLayout()
        case .characters:
            return createCharactersLayout()
        }
    }
    
    func createInfoLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        ), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createCharactersLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(300)), subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
