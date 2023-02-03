//
//  LocationTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/02/23.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "LocationTableViewCell"
    
    internal lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    internal lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    internal lazy var dimensionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        contentView.backgroundColor = .systemBackground
        
        let stack = UIStackView(arrangedSubviews: [typeLabel, dimensionLabel])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 3
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviews(nameLabel, stack)
        NSLayoutConstraint.activate([
        
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            stack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    public func configure(with viewModel: LocationTableViewCellVM) {
        
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        dimensionLabel.text = viewModel.dimension
    }
    
    private func updateColors() {
        self.contentView.layer.borderColor = UIColor.systemGray3.withAlphaComponent(0.3).cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateColors()
        self.setNeedsDisplay()
    }
}
