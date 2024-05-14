//
//  FavouritesTableViewCell.swift
//  MovieApp
//
//  Created by O'lmasbek on 13/05/24.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
    
    static let cellId = "FavouritesTableViewCell"
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.image = UIImage(named: "panda")
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.montserratBlack(size: 18)
        label.textColor = .white
        label.text = "Kungfu Panda 4"
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.gruppoRegular(size: 18)
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.text = "Kungfu Panda 4"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(movieImage)
        contentView.addSubview(labelsStack)
        labelsStack.addArrangedSubview(nameLabel)
        labelsStack.addArrangedSubview(genreLabel)
        backgroundColor = .clear
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 118),
            movieImage.widthAnchor.constraint(equalToConstant: 118),
            
            labelsStack.leftAnchor.constraint(equalTo: movieImage.rightAnchor, constant: 16),
            labelsStack.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor),
            labelsStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
    
    func configureCell(with viewModel: FavouritesMovieCellViewViewModel) {
        guard let url = URL(string: viewModel.imageUrlStr) else { return }
        
        movieImage.sd_setImage(with: url, placeholderImage: UIImage(named: "noImage"))
        nameLabel.text = viewModel.movieName
        genreLabel.text = viewModel.movieGenre
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
