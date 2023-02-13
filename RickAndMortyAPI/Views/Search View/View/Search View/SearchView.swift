//
//  SearchView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    
    func searchInputView(_ inputView: SearchInputView, didSelectOption option: SearchInputViewVM.DynamicOption)
}

final class SearchView: UIView {
    
    // MARK: - Properties
    private let viewModel: SearchViewVM
    
    private let noResultsView = NoSearchResultsView()
    private let searchInputView = SearchInputView()
    
    weak var delegate: SearchVCDelegate?
 
    // MARK: - Lifecycle
    init(frame: CGRect, viewModel: SearchViewVM) {
        
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        searchInputView.configure(with: SearchInputViewVM(type: viewModel.config.type))
        searchInputView.delegate = self

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        self.backgroundColor = .systemBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(noResultsView, searchInputView)
        NSLayoutConstraint.activate([
        
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noResultsView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            searchInputView.topAnchor.constraint(equalTo: self.topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: self.leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: self.rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110)
        ])
    }
    
    func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
}
