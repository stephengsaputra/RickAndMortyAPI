//
//  SearchInputView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

final class SearchInputView: UIView {
    
    // MARK: - Properties
    internal lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private var viewModel: SearchInputViewVM? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
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
        
        self.addSubviews(searchBar)
        NSLayoutConstraint.activate([
        
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    func configure(with viewModel: SearchInputViewVM) {
        
        self.viewModel = viewModel
        searchBar.placeholder = viewModel.searchPlaceholderText
    }
    
    func createOptionSelectionViews(options: [SearchInputViewVM.DynamicOption]) {
        
        for option in options {
            print(option.rawValue)
        }
    }
}
