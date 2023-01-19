//
//  EpisodeInfoCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 19/01/23.
//

import UIKit

final class EpisodeInfoCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    static let identifier = "EpisodeInfoCollectionViewCell"
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configure(with viewModel: EpisodeInfoCollectionViewCellVM) {
        
    }
    
    func configureUI() {
        
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
}
