//
//  CharacterListVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation
import UIKit

final class CharacterListVM: NSObject {

    func fetchCharacters() {
        
        APIService.shared.execute(.listCharactersRequests, expecting: CharactersResponse.self) { result in
            switch result {
                case .success(let model):
                    print("Total: \(model.info?.count)")
                    print("Page results count: \(model.results?.count)")
                case .failure(let error):
                    print(error)
            }
        }
    }
}

extension CharacterListVM: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 45) / 2
        
        return CGSize(width: width, height: width * 1.5)
    }
}
