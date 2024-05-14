//
//  FavouritesMovieCellViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 13/05/24.
//

import Foundation

class FavouritesMovieCellViewViewModel {
    
    let favouriteMovie: FavouriteMovie
    
    init(favouriteMovie: FavouriteMovie) {
        self.favouriteMovie = favouriteMovie
    }
    
    public var imageUrlStr: String {
        return favouriteMovie.imageUrlStr
    }
    
    public var movieName: String {
        return favouriteMovie.movieName
    }
    
    public var movieGenre: String {
        return favouriteMovie.movieGenre
    }
    
    public var id: Int {
        return favouriteMovie.id
    }
}
