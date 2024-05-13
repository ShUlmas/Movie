//
//  NetworkService.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import Foundation

protocol Networking {
    func createRequest(urlString: String, compilation: @escaping(Data?, Error?) -> Void)
}

class NetworkService {
    private func createDataTask(from request: URLRequest, compilation: @escaping(Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.sync {
                compilation(data, error)
            }
        }
    }
}

extension NetworkService: Networking {
    func createRequest(urlString: String, compilation: @escaping (Data?, (any Error)?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, compilation: compilation)

        task.resume()
    }
}
