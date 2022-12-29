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
                    print("\(String(describing: model))")
                    print("Image URL: \(model.results?.first?.image ?? "No Image!")")
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

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }

        let vm = CharacterCollectionViewCellVM(characterName: "Stephen Giovanni Saputra", characterStatus: .alive, characterImageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        cell.configure(with: vm)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 45) / 2

        return CGSize(width: width, height: width * 1.5)
    }
}
