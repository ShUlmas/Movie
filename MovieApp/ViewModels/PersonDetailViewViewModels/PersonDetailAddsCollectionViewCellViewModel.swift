//
//  PersonDetailAddsCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 03/05/24.
//

import Foundation

enum AddsType {
    case gender
    case birthday
    case knownFor
    case popularity
}

class PersonDetailAddsCollectionViewCellViewModel {
    
    var type: AddsType
    let info: String
    
    init(type: AddsType, info: String) {
        self.type = type
        self.info = info
    }
    
    public var title: String {
        switch type {
        case .gender:
            return "Gender"
        case .birthday:
            return "Birthday"
        case .knownFor:
            return "Known for"
        case .popularity:
            return "Popularity"
        }
    }
}
