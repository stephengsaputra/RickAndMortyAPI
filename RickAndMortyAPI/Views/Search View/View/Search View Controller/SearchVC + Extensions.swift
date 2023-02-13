//
//  SearchVC + Extensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 13/02/23.
//

import UIKit

extension SearchVC: SearchVCDelegate {
    
    func searchView(_: SearchView, didSelectOption option: SearchInputViewVM.DynamicOption) {
        
        let vc = SearchOptionPickerVC(option: option) { selection in
            print(selection)
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.preferredCornerRadius = 20
        vc.sheetPresentationController?.prefersGrabberVisible = true
        self.present(vc, animated: true)
    }
}
