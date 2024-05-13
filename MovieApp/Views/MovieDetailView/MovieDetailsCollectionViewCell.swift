//
//  MovieDetailsCollectionViewCell.swift
//  MovieApp
//
//  Created by O'lmasbek on 01/05/24.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "MovieDetailsCollectionViewCell"
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "panda")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.montserratBlack(size: 22)
        label.text = "Spiderman no way home"
        label.textColor = .white
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.gruppoRegular(size: 20)
        label.text = "Released • 2020 • 120 min"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.85)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.gruppoRegular(size: 20)
        label.text = "Action • Thrill • Comedy"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.85)
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.gruppoRegular(size: 16)
        label.text = "Spiderman no way home lorem ipsum dolor sit amet no way home lorem ipsum dolor sit amet no way home lorem ipsum dolor sit amet no way home lorem ipsum dolor sit amet no way home lorem ipsum dolor sit amet no way home lorem ipsum dolor sit amet no way home lorem ipsum dolor sit amet no way home lorem ipsum dolor sit amet"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.55)
        label.numberOfLines = 6
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(releaseLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(movieOverviewLabel)

        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            movieImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.7),
            
            movieTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            movieTitleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 16),
            movieTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            releaseLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
            releaseLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            releaseLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            genresLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 8),
            genresLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            genresLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            movieOverviewLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 8),
            movieOverviewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            movieOverviewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
    }
    
    func configureCell(with viewModel: MovieDetailsCollectionViewCellViewModel) {
        guard let url = URL(string: viewModel.movieImageUrlString) else {
            return
        }
        
        movieImage.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"))
        movieTitleLabel.text = viewModel.movieTitle
        releaseLabel.text = viewModel.movieRelease
        genresLabel.text = viewModel.movieGenre
        movieOverviewLabel.text = viewModel.moovieOverview
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
