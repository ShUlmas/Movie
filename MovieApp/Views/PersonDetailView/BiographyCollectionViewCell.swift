//
//  BiographyCollectionViewCell.swift
//  MovieApp
//
//  Created by O'lmasbek on 03/05/24.
//

import UIKit

class BiographyCollectionViewCell: UICollectionViewCell {
    static let cellID = "BiographyCollectionViewCell"
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.gruppoRegular(size: 16)
        label.textColor = .white
        label.numberOfLines = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bioLabel)
        
        NSLayoutConstraint.activate([
            bioLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bioLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bioLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    func configureCell(with viewModel: PersonBiographyCollectionViewCellViewModel) {
        bioLabel.text = viewModel.personBio
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
