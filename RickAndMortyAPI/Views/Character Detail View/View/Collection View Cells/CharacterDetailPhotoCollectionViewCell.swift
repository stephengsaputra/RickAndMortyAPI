//
//  CharacterDetailPhotoCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 07/01/23.
//

import UIKit

final class CharacterDetailPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CharacterDetailPhotoCollectionViewCell"
    
    internal lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        imageView.image = nil
    }
    
    func configure(with viewModel: CharacterDetailPhotoVM) {
        
        viewModel.fetchImage { [weak self] result in
           
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: success)
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    // MARK: - Helpers
    private func configureUI() {
        
        contentView.backgroundColor = .red
        
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
