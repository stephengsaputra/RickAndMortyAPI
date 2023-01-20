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
    
    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    internal lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
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
        
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configure(with viewModel: EpisodeInfoCollectionViewCellVM) {
        
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
    
    func configureUI() {
        
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        contentView.addSubviews(titleLabel, valueLabel)
        NSLayoutConstraint.activate([
        
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12)
        ])
    }
}
