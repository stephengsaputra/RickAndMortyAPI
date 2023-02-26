//
//  SearchView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    
    func searchInputView(_ inputView: SearchInputView, didSelectOption option: SearchInputViewVM.DynamicOption)
    func searchInputView(_ inputView: SearchInputView, didChangeSearchText text: String)
    func didTapSearchKeyboard(_ inputView: SearchInputView)
}

final class SearchView: UIView {
    
    // MARK: - Properties
    internal let viewModel: SearchViewVM
    
    private let noResultsView = NoSearchResultsView()
    private let searchInputView = SearchInputView()
    
    weak var delegate: SearchVCDelegate?
 
    // MARK: - Lifecycle
    init(frame: CGRect, viewModel: SearchViewVM) {
        
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        searchInputView.configure(with: SearchInputViewVM(type: viewModel.config.type))
        searchInputView.delegate = self
        
        viewModel.registerOptionChangeBlock { tuple in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }

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
