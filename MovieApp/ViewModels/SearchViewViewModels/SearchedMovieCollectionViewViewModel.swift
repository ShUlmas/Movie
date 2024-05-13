//
//  SearchedMovieCollectionViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 30/04/24.
//

import Foundation


class SearchedMovieCollectionViewViewModel {
    
    let searchedMovie: SearchedMovie
    
    init(searchedMovie: SearchedMovie) {
        self.searchedMovie = searchedMovie
    }
    
    public var displayImageUrl: String {
        return Constants.shared.imageBaseUrl + (searchedMovie.posterPath ?? "")
    }
    
    public var displayMovieName: String {
        return searchedMovie.name ?? ""
    }
    
    public var id: Int {
        return searchedMovie.id
    }
    
}
