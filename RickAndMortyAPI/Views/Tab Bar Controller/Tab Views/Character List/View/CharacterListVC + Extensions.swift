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
        
        print(String(describing: self.viewModel.characters[indexPath.row].image ?? ""))
    }
}

extension CharacterListVC: CharacterListVMDelegate {
    
    func didLoadInitialCharacters() {
        
        spinner.stopAnimating()
        collectionView.reloadData()
        
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
