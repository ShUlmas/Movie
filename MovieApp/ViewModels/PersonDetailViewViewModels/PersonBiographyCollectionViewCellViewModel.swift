//
//  PersonBiographyCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 03/05/24.
//

import Foundation

class PersonBiographyCollectionViewCellViewModel {
    
    let personBiography: String?
    
    init(personBiography: String) {
        self.personBiography = personBiography
    }
    
    public var personBio: String {
        return personBiography ?? "Cannot find biography info"
    }
}
