//
//  PersistenceManager.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/05/24.
//

import Foundation

enum MError: String, Error {
    case unableToFavorite = "Favorites error"
    case alreadyInFavorites = "This movie is already in favorites"
}

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(favorite: FavouriteMovie, actionType: PersistanceActionType, completed: @escaping(MError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll(where: { $0.id == favorite.id })
                }
                
                completed(saveFavorite(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping(Result<[FavouriteMovie], MError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
    
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavouriteMovie].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func saveFavorite(favorites: [FavouriteMovie]) -> MError? {
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
