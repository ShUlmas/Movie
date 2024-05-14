//
//  MovieDetailsCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 01/05/24.
//

import Foundation

class MovieDetailsCollectionViewCellViewModel {
    let movieDetails: MovieDetails?
    
    init(movieDetails: MovieDetails) {
        self.movieDetails = movieDetails
    }
    
    public var movieTitle: String {
        return movieDetails!.title
    }
    
    public var movieRelease: String {
        return "Released • \(movieDetails!.releaseDate) • \(movieDetails!.runtime) min"
    }
    
    public var movieGenre: String {
        var genres = ""
        
        for genre in movieDetails!.genres {
            let name = genre.name
            genres += name + " • "
        }

        if !genres.isEmpty {
            genres.removeLast(2) // oxirgi nuqtani o'chirish
        }

        return genres
    }
    
    public var moovieOverview: String {
        return movieDetails!.overview
    }
    
    public var movieImageUrlString: String {
        return Constants.shared.imageBaseUrl + (movieDetails!.posterPath ?? "")
    }
    
    public var id: Int {
        return movieDetails?.id ?? 0
    }
}
