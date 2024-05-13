//
//  PersonDetailCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 02/05/24.
//

import Foundation

class PersonDetailCollectionViewCellViewModel {
    
    let personDetails: PersonDetails
    
    init(personDetails: PersonDetails) {
        self.personDetails = personDetails
    }
    
    public var personName: String {
        return personDetails.name
    }
    
    public var placeOfBirth: String {
        return personDetails.placeOfBirth ?? "Cannot find place of birth info"
    }
    
    public var gender: Int {
        return personDetails.gender ?? 1
    }
    
    public var personImageUrlString: String {
        return Constants.shared.imageBaseUrl + (personDetails.profilePath ?? "")
    }
}
