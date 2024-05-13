//
//  TopCastCollectionViewCell.swift
//  MovieApp
//
//  Created by O'lmasbek on 01/05/24.
//

import UIKit
import SDWebImage

class PersonCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "TopCastCollectionViewCell"
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.montserratBlack(size: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.55)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            profileImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: contentView.frame.width - 24),
            profileImage.widthAnchor.constraint(equalToConstant: contentView.frame.width - 24),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
        ])
        
        profileImage.layer.cornerRadius = contentView.frame.width / 2 - 12
    }
    
    func configureCell(with viewModel: TopCastsCollectionViewCellViewModel) {
        guard let url = URL(string: viewModel.imageUrlString) else { return }
        
        profileImage.sd_setImage(
            with: url,
            placeholderImage: UIImage(named: viewModel.gender == 1 ? "womanPersonNoImage" : "personNoImage")
        )
        nameLabel.text = viewModel.actorName
    }
    
    func configurePersonCell(with viewModel: PersonCollectionViewCellViewModel) {
        profileImage.image = UIImage(named: viewModel.gender == 1 ? "womanPersonNoImage" : "personNoImage")
        nameLabel.text = viewModel.personName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
