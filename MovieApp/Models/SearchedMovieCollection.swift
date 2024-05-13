//
//  SearchedMovieCollection.swift
//  MovieApp
//
//  Created by O'lmasbek on 30/04/24.
//

import Foundation


struct SearchedMovieCollection: Codable {
    let page: Int?
    let results: [SearchedMovie]
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct SearchedMovie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int
    let name, originalLanguage, originalName, overview: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
    }
}
