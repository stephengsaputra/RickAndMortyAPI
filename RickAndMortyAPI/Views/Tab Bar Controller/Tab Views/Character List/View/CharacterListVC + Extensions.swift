//
//  CharacterListVC + Extensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 31/12/22.
//

import Foundation
import UIKit

extension CharacterListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }

        let vm = CharacterCollectionViewCellVM(
            characterName: self.viewModel.characters[indexPath.row].name ?? "",
            characterStatus: self.viewModel.characters[indexPath.row].status ?? .unknown,
            characterImageURL: URL(string: self.viewModel.characters[indexPath.row].image ?? "")
        )
        cell.configure(with: vm)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 45) / 2

        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let character = viewModel.characters[indexPath.row]
        let vm = CharacterDetailVM(character: character)
        
        let vc = CharacterDetailVC(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingFooterCollectionReusableView.identifier, for: indexPath) as? LoadingFooterCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard viewModel.shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard viewModel.shouldShowLoadMoreIndicator, !viewModel.isLoadingMoreCharacters, let nextURLString = viewModel.apiInfo?.next, let url = URL(string: nextURLString) else { return }
        
        let lastElement = viewModel.characters.count - 1
        
        if indexPath.row == lastElement {
            
            viewModel.fetchMoreCharacters(url: url)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.collectionView.reloadData()
            }
        }
    }
}

extension CharacterListVC: CharacterListVCDelegate {
    
    func didLoadInitialCharacters() {
        
        spinner.stopAnimating()
        collectionView.reloadData()
        
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
