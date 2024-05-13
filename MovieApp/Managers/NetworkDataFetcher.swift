//
//  NetworkDataFetcher.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import Foundation

protocol DataFetcher {
    func fetchJSONData<T: Codable>(urlString: String, response: @escaping(T?) -> Void)
}

class NetworkDataFetcher {
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    /// decode json
    func decodeJSON<T: Codable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        
        guard let data = data else { return nil }
        
        do {
            let data = try decoder.decode(type, from: data)
            return data
        } catch let error {
            print("decode error: \(error)")
            return nil
        }
    }
}

extension NetworkDataFetcher: DataFetcher {
    func fetchJSONData<T: Codable>(urlString: String, response: @escaping (T?) -> Void) {
        networking.createRequest(urlString: urlString) { data, error in
            if error != nil {
                print("fetching json data error")
                response(nil)
            }
            
            let decodedJSON = self.decodeJSON(type: T.self, from: data)
            response(decodedJSON)
        }
    }
}
