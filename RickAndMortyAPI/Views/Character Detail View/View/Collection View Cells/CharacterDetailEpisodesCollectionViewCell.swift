//
//  CharacterDetailEpisodesCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 07/01/23.
//

import UIKit

class CharacterDetailEpisodesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CharacterDetailEpisodesCollectionViewCell"
    
    internal lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var episodeSeasonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var episodeAirDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    internal lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [episodeNameLabel, episodeSeasonLabel, episodeAirDateLabel])
        stack.spacing = 3
        stack.alignment = .leading
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    }
    
    func configure(with viewModel: CharacterDetailEpisodesVM) {
        
        viewModel.registerForData { [weak self] data in
            self?.episodeNameLabel.text = data.name
            self?.episodeSeasonLabel.text = data.episode
            self?.episodeAirDateLabel.text = data.airDate
        }
        
        viewModel.fetchEpisode()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
        ])
    }
}
