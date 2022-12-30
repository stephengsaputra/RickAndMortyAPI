//
//  CharacterCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import UIKit

/// Single cell for a character
class CharacterCollectionViewCell: UICollectionViewCell {
    
    var disabledHighlightedAnimation = false
    
    // MARK: - Cell animation when touched
    func freezeAnimations() {
        disabledHighlightedAnimation = true
        layer.removeAllAnimations()
    }
    
    func unfreezeAnimations() {
        disabledHighlightedAnimation = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        
        if disabledHighlightedAnimation {
            return
        }
        
        if isHighlighted {
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: [.allowUserInteraction], animations: {
                self.transform = .init(scaleX: 0.98, y: 0.98)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: [.allowUserInteraction], animations: {
                self.transform = .identity
            }, completion: completion)
        }
    }
    
    // MARK: - Properties
    static let identifier = "CharacterCollectionViewCell"
    
    internal lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    internal lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    internal lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        imageView.image = nil
        nameLabel.text = nil
        secondaryLabel.text = nil
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubviews(imageView, nameLabel, secondaryLabel)
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: secondaryLabel.topAnchor, constant: -2),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            secondaryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            secondaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            secondaryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
        
        contentView.clipsToBounds = true
        
        contentView.layer.cornerRadius = 12
        
        contentView.layer.borderColor = UIColor.systemGray3.withAlphaComponent(0.3).cgColor
        contentView.layer.borderWidth = 1.5
    }
    
    private func updateColors() {
        self.contentView.layer.borderColor = UIColor.systemGray3.withAlphaComponent(0.3).cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateColors()
        self.setNeedsDisplay()
    }
    
    public func configure(with viewModel: CharacterCollectionViewCellVM) {
        
        nameLabel.text = viewModel.characterName
        secondaryLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    let image = UIImage(data: success)
                    self?.imageView.image = image
                }
            case .failure(let failure):
                print(String(describing: failure))
                break
            }
        }
    }
}
