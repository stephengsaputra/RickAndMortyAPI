//
//  NoSearchResultsView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

final class NoSearchResultsView: UIView {
 
    // MARK: - Properties
    private let viewModel = NoSearchResultsViewVM()
    
    internal lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    internal lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        
        super.init(frame: .zero)
        configureUI()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = true
        
        let stack = UIStackView(arrangedSubviews: [iconView, label])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 10
        
        self.addSubviews(stack)
        NSLayoutConstraint.activate([
            
            iconView.widthAnchor.constraint(equalToConstant: 100),
            iconView.heightAnchor.constraint(equalToConstant: 100),
            
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configure() {
        
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
}
