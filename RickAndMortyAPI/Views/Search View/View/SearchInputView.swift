//
//  SearchInputView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

final class SearchInputView: UIView {
    
    weak var delegate: SearchViewDelegate?
    
    // MARK: - Properties
    internal lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    internal lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 6
        return stackView
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
    @objc func handleButton(_ sender: UIButton) {
        
        guard let options = viewModel?.options else {
            return
        }
        
        let tag = sender.tag
        let selected = options[tag]
        
        delegate?.searchInputView(self, didSelectOption: selected)
    }
    
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
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        for i in 0..<options.count {
            
            let option = options[i]
            let button = createButton(with: option, tag: i)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    func createButton(with option: SearchInputViewVM.DynamicOption, tag: Int) -> UIButton {
        
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(
            string: option.rawValue,
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                .foregroundColor: UIColor.label
            ]
        ), for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemYellow
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        button.tag = tag
        
        return button
    }
}
