//
//  PersonCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/05/24.
//

import Foundation

class PersonCollectionViewCellViewModel {
    let person: Person
    
    init(person: Person) {
        self.person = person
    }
    
    public var id: Int {
        return person.id ?? 0
    }
    
    public var personName: String {
        return person.name ?? "No name"
    }
    
    public var gender: Int {
        return person.gender ?? 1
    }
}
