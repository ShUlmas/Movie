//
//  PersonDetails.swift
//  MovieApp
//
//  Created by O'lmasbek on 02/05/24.
//

import Foundation

struct PersonDetails: Codable {
    let adult: Bool?
    let alsoKnownAs: [String]?
    let biography: String?
    let birthday: String?
    let gender: Int?
    let homepage: String?
    let id: Int
    let imdbID: String?
    let knownForDepartment: String?
    let name: String
    let placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, gender, id, homepage
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}
