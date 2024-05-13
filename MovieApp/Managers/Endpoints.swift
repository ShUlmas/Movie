//
//  Endpoints.swift
//  MovieApp
//
//  Created by O'lmasbek on 26/04/24.
//

import Foundation

enum Endpoints: String {
    case trendingMoviesEndpoint = "/trending/movie/day"
    case upcomingMoviesEndpoint = "/movie/upcoming"
    case topRatedMoviesEndpoint = "/movie/top_rated"
    case popularMoviesEndpoint = "/movie/popular"
    case searchMoviesEndpoint = "/search/movie"
}
