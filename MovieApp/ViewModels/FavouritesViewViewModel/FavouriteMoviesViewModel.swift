//
//  FavouriteMoviesViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 13/05/24.
//

import Foundation

class FavouriteMoviesViewModel {
    
    var favouriteMovies = [FavouriteMovie]()
    
    var favouriteMoviesCollectionViewCellViewModels: [FavouritesMovieCellViewViewModel] = []
    
    init() {
        fetchFavouriteMovies()
    }
    
    func fetchFavouriteMovies() {
        PersistanceManager.retrieveFavorites { result in
            switch result {
            case .success(let favouriteMovies):
                self.favouriteMovies = favouriteMovies
                self.favouriteMoviesCollectionViewCellViewModels = favouriteMovies.map { FavouritesMovieCellViewViewModel(favouriteMovie: $0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
