//
//  MoreMoviesViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 11/05/24.
//

import Foundation

class MoreMoviesViewViewModel {
    
    var viewTitleStr = ""
    var endpoint: Endpoints? = nil
    private let dataFetcherService = DataFetcherService()
    
    public var movies: [MovieCollectionViewCellViewModel] = []
    
    var page: Int = 1
    var isPageRefreshing: Bool = true
    
    func fetchMovies(completion: @escaping() -> ()) {
        
        guard let endpoint = endpoint else { return }
        
        dataFetcherService.fetchMovies(page: page, endpoint: endpoint) { movies in
            guard let movies = movies else { return }
            let movieCellViewModels = movies.results.map { MovieCollectionViewCellViewModel(movie: $0) }
            self.movies.append(contentsOf: movieCellViewModels)
            completion()
        }
    }
}
