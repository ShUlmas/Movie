//
//  TrendingMoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    static let cellID = "TrendingMoviesCollectionViewCell"
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "panda")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameBackGradientView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.montserratBlack(size: 19)
        label.textColor = .white
        label.numberOfLines = 1
        label.text = "Kungfu panda 4"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(nameBackGradientView)
        contentView.addSubview(movieNameLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            movieImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameBackGradientView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameBackGradientView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameBackGradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameBackGradientView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.7),
            
            movieNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            movieNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            movieNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
        clipsToBounds = true
        
        DispatchQueue.main.async {
            self.nameBackGradientView.addGradientBackground(topColor: .clear, bottomColor: .black)
        }
    }
    
    /// Configure
    func configureCell(with viewModel: MovieCollectionViewCellViewModel) {
        guard let url = URL(string: viewModel.displayImageUrl) else { return }
        self.movieImageView.sd_setImage(with: url)
        self.movieNameLabel.text = viewModel.displayMovieName
    }
    
    func configureSearchedMovie(with viewModel: SearchedMovieCollectionViewViewModel) {
        guard let url = URL(string: viewModel.displayImageUrl) else { return }
        self.movieImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"))
        self.movieNameLabel.text = viewModel.displayMovieName
    }
    
    func configureSimilarMovieCell(with viewModel: SimilarMovieViewModel) {
        guard let url = URL(string: viewModel.displayImageUrl) else { return }
        self.movieImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"))
        self.movieNameLabel.text = viewModel.displayMovieName
    }
    
    func configurePersonMovieCreditCell(with viewModel: PersonMovieCreditCollectionViewViewModel) {
        guard let url = URL(string: viewModel.imageUrlString) else { return }
        self.movieImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"))
        self.movieNameLabel.text = viewModel.title
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
