//
//  SearchInputView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

/// View for top part of search screen with search bar
final class SearchInputView: UIView {
    
    weak var delegate: SearchViewDelegate?
    
    // MARK: - Properties
    internal lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        return searchBar
    }()
    
    internal lazy var stackView: UIStackView? = {
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
        
        self.addSubview(stackView!)
        NSLayoutConstraint.activate([
            
            stackView!.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            stackView!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            stackView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        for i in 0..<options.count {
            
            let option = options[i]
            let button = createButton(with: option, tag: i)
            
            stackView!.addArrangedSubview(button)
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
    
    public func update(option: SearchInputViewVM.DynamicOption, value: String) {
        
        guard let buttons = stackView?.arrangedSubviews as? [UIButton], let allOptions = viewModel?.options, let index = allOptions.firstIndex(of: option) else {
                return
            }
        
        buttons[index].setAttributedTitle(NSAttributedString(
            string: value,
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .medium),
                .foregroundColor: UIColor.link
            ]
        ), for: .normal)
    }
}

extension SearchInputView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Notify the delegate of changed text
        delegate?.searchInputView(self, didChangeSearchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Notify that search button was tapped
        searchBar.resignFirstResponder()
        delegate?.didTapSearchKeyboard(self)
    }
}
