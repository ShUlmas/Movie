//
//  PersonDetailAddsCollectionViewCell.swift
//  MovieApp
//
//  Created by O'lmasbek on 03/05/24.
//

import UIKit

class PersonDetailAddsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "PersonDetailAddsCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.montserratSemiBold(size: 12)
        label.textColor = .white
        label.text = "Known for"
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.gruppoRegular(size: 14)
        label.textColor = .white
        label.text = "1964-09-02"
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 12
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2),
            
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2),
        ])
        
    }
    
    func configureCell(with viewModel: PersonDetailAddsCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        infoLabel.text = viewModel.info
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
