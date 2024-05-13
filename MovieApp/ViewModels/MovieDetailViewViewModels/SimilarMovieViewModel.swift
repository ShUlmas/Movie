//
//  SimilarMovieViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 01/05/24.
//

import Foundation

class SimilarMovieViewModel {
    
    let similarMovie: SimilarMovie
    
    init(similarMovie: SimilarMovie) {
        self.similarMovie = similarMovie
    }
    
    public var displayImageUrl: String {
        return Constants.shared.imageBaseUrl + (similarMovie.posterPath ?? "")
    }
    
    public var displayMovieName: String {
        return similarMovie.title
    }
    
    public var id: Int {
        return similarMovie.id
    }
}
