//
//  TopCastsCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 01/05/24.
//

import Foundation

class TopCastsCollectionViewCellViewModel {
     
    let cast: Cast
    
    init(cast: Cast) {
        self.cast = cast
    }
    
    public var imageUrlString: String {
        return Constants.shared.imageBaseUrl + (cast.profilePath ?? "")
    }
    
    public var actorName: String {
        return cast.name
    }
    
    public var gender: Int {
        return cast.gender
    }
    
    public var id: Int {
        return cast.id
    }
}
