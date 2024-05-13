//
//  PersonMovieCreditCollectionViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 03/05/24.
//

import Foundation

class PersonMovieCreditCollectionViewViewModel {
    let personMovie: PersonMovieCredit
    
    init(personMovie: PersonMovieCredit) {
        self.personMovie = personMovie
    }
    
    public var title: String {
        return personMovie.title
    }
    
    public var imageUrlString: String {
        Constants.shared.imageBaseUrl + (personMovie.posterPath ?? "")
    }
    
    public var id: Int {
        return personMovie.id
    }
}
