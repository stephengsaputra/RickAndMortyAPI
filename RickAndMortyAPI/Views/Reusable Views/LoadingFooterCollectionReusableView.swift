//
//  LoadingFooterCollectionReusableView.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 01/01/23.
//

import UIKit

final class LoadingFooterCollectionReusableView: UICollectionReusableView {
        
    // MARK: - Properties
    static let identifier = "LoadingFooterCollectionReusableView"
    
    internal lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        
        self.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func startSpinnerAnimation() {
        
        spinner.startAnimating()    
    }
}
