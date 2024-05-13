//
//  DataFetcherService.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import Foundation

class DataFetcherService {
    var networkDataFetcher: DataFetcher
    var endpoint: Endpoints?
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchMovies(page: Int = 1, endpoint: Endpoints, compilation: @escaping(Movies?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl + endpoint.rawValue)?api_key=\(Constants.shared.apiKey)&page=\(page)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
    
    //MARK: - SEARCH MOVIE
    func fetchSearchedMovies(query: String, compilation: @escaping(SearchedMovieCollection?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl + Endpoints.searchMoviesEndpoint.rawValue)?api_key=\(Constants.shared.apiKey)&&query=\(query)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
    
    //MARK: - MOVIE DETAILS
    func fetchMovieDetails(id: Int, compilation: @escaping(MovieDetails?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl)/movie/\(id)?api_key=\(Constants.shared.apiKey)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
    
    func fetchMovieCredits(id: Int, compilation: @escaping(Credits?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl)/movie/\(id)/credits?api_key=\(Constants.shared.apiKey)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
    
    func fetchSimilarMovies(id: Int, compilation: @escaping(SimilarMovies?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl)/movie/\(id)/similar?api_key=\(Constants.shared.apiKey)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
    
    //MARK: - FETCH PERSON DETAILS
    func fetchPersonDetails(id: Int, compilation: @escaping(PersonDetails?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl)/person/\(id)?api_key=\(Constants.shared.apiKey)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
    
    func fetchPersonMovieCredits(id: Int, compilation: @escaping(PersonMovieCreditsArray?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl)/person/\(id)/movie_credits?api_key=\(Constants.shared.apiKey)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
    
    func fetchPersons(page: Int, compilation: @escaping(Persons?) -> Void) {
        let urlString = "\(Constants.shared.baseUrl)/person/popular?api_key=\(Constants.shared.apiKey)&page=\(page)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: compilation)
    }
}
