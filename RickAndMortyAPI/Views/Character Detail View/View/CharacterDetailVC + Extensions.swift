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
        
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
            case .photo:
                return 1
            case .information(let viewModels):
                return viewModels.count
            case .episodes(let viewModels):
                return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .photo(let viewModel):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterDetailPhotoCollectionViewCell.identifier,
                for: indexPath) as! CharacterDetailPhotoCollectionViewCell
            cell.configure(with: viewModel)
            cell.backgroundColor = .systemPurple
            return cell
        case .information(let viewModels):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterDetailInformationCollectionViewCell.identifier,
                for: indexPath) as! CharacterDetailInformationCollectionViewCell
            cell.configure(with: viewModels[indexPath.row])
            cell.backgroundColor = .systemBlue
            cell.layer.cornerRadius = 12
            return cell
        case .episodes(let viewModels):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterDetailEpisodesCollectionViewCell.identifier,
                for: indexPath) as! CharacterDetailEpisodesCollectionViewCell
            cell.configure(with: viewModels[indexPath.row])
            cell.backgroundColor = .systemOrange
            cell.layer.cornerRadius = 12
            return cell
        }
    }
    
    // MARK: - CollectionView Layout
    internal func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
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
            heightDimension: .fractionalHeight(0.5)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createInformationSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(150)), subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

