//
//  FavouriteMovie.swift
//  MovieApp
//
//  Created by O'lmasbek on 13/05/24.
//

import Foundation

struct FavouriteMovie: Codable, Hashable {
    let id: Int
    let imageUrlStr: String
    let movieName: String
    let movieGenre: String
}
