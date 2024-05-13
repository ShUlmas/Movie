//
//  SearchViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 30/04/24.
//

import Foundation


class SearchViewViewModel {
    
    var dataFetcherService = DataFetcherService()
    var searchResults: [SearchedMovieCollectionViewViewModel] = []
    
    func getSearchedMovies(text: String, completion: @escaping() -> ()) {
        dataFetcherService.fetchSearchedMovies(query: text) { searchedMovies in
            guard let searchedMovies = searchedMovies else { return }
            self.searchResults = searchedMovies.results.map { SearchedMovieCollectionViewViewModel(searchedMovie: $0) }
            completion()
        }
    }
}
