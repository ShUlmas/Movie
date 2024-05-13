//
//  PersonsViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/05/24.
//

import Foundation

class PersonsViewViewModel {
    
    private let dataFetcherService = DataFetcherService()
    
    public var persons: [PersonCollectionViewCellViewModel] = []
    
    var page: Int = 1
    var isPageRefreshing: Bool = true
    
    func fetchPersons(completion: @escaping() -> ()) {
            
        dataFetcherService.fetchPersons(page: page) { persons in
            guard let persons = persons else { return }
            let personsViewModels = persons.results.map { PersonCollectionViewCellViewModel(person: $0) }
            self.persons.append(contentsOf: personsViewModels)
            completion()
        }
    }
}
