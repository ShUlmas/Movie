//
//  MovieCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import UIKit

class MovieCollectionViewCellViewModel {
    let movie: Movie
    init(movie: Movie) {
        self.movie = movie
    }
    
    public var displayImageUrl: String {
        return Constants.shared.imageBaseUrl + (movie.posterPath ?? "no poster path")
    }
    
    public var displayMovieName: String {
        return movie.title ?? "No title"
    }
    
    public var id: Int {
        return movie.id
    }
}
