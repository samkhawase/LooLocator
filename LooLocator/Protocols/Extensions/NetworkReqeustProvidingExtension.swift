//
//  NetworkReqeustProvidingExtension.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//

import Foundation

extension NetworkRequestProviding {
    internal var baseUrl: String {
        let _baseUrl = "https://overpass-api.de/api/interpreter"
        return _baseUrl
    }
    
    func dataTask(request: NSMutableURLRequest,
                  completion: @escaping (Result<SerializedType, Error>) -> Void) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            let decoder = JSONDecoder()
            if let data = data,
               let serverResponse = try? decoder.decode(SerializedType.self, from: data),
               let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                completion(.success(serverResponse))
            } else {
                completion(.failure(NSError(domain: "in.b3rl", code: 999, userInfo: nil)))
            }
        }.resume()
    }
}
