//
//  CharacterDetailInformationCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 07/01/23.
//

import UIKit

class CharacterDetailInformationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CharacterDetailInformationCollectionViewCell"
    
    internal lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    internal lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    internal lazy var titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiarySystemBackground
        view.clipsToBounds = true
        return view
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
        
        valueLabel.text = nil
        titleLabel.text = nil
        iconImage.image = nil
        iconImage.tintColor = .systemBlue
    }
    
    func configure(with viewModel: CharacterDetailInformationVM) {
        
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImage.image = viewModel.displayImage
        iconImage.tintColor = viewModel.tintColor
    }
    
    // MARK: - Helpers
    private func configureUI() {
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        titleContainerView.addSubview(titleLabel)
        
        contentView.addSubviews(titleContainerView, valueLabel, iconImage)
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: -10),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            valueLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImage.bottomAnchor.constraint(equalTo: valueLabel.topAnchor)
        ])
    }
}
