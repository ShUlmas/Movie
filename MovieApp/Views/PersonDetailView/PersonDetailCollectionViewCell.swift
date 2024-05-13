//
//  PeopleDetailCollectionViewCell.swift
//  MovieApp
//
//  Created by O'lmasbek on 02/05/24.
//

import UIKit

class PersonDetailCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "PersonDetailCollectionViewCell"
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.montserratBlack(size: 22)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var placeOfBirthLabel: UILabel = {
        let label = UILabel()
        label.montserratBlack(size: 15)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5509364652)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let neuView = NeuView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(neuView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(placeOfBirthLabel)
        
        setupConstraints()
        
        profileImage.layer.cornerRadius = 110
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            neuView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            neuView.widthAnchor.constraint(equalToConstant: 220),
            neuView.heightAnchor.constraint(equalToConstant: 220),
            neuView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: neuView.bottomAnchor, constant: 24),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            placeOfBirthLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            placeOfBirthLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            placeOfBirthLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
        ])
    }
    
    func configureCell(with viewModel: PersonDetailCollectionViewCellViewModel) {
        
        guard let url = URL(string: viewModel.personImageUrlString) else { return }
        neuView.imgView.sd_setImage(
            with: url,
            placeholderImage: UIImage(named: viewModel.gender == 1 ? "womanPersonNoImage" : "personNoImage")
        )
        nameLabel.text = viewModel.personName
        placeOfBirthLabel.text = viewModel.placeOfBirth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
