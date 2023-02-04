//
//  SearchView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

final class SearchView: UIView {
    
    // MARK: - Properties
    private let viewModel: SearchViewVM
    
    private let noResultsView = NoSearchResultsView()
 
    // MARK: - Lifecycle
    init(frame: CGRect, viewModel: SearchViewVM) {
        
        self.viewModel = viewModel
        super.init(frame: .zero)

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
        
        self.addSubview(noResultsView)
        NSLayoutConstraint.activate([
        
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noResultsView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}


