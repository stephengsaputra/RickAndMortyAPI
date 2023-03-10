//
//  SearchVC + Extensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 13/02/23.
//

import UIKit

extension SearchVC: SearchVCDelegate {
    
    func searchView(_: SearchView, didSelectOption option: SearchInputViewVM.DynamicOption) {
        
        let vc = SearchOptionPickerVC(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.preferredCornerRadius = 20
        vc.sheetPresentationController?.prefersGrabberVisible = true
        self.present(vc, animated: true)
    }
}
