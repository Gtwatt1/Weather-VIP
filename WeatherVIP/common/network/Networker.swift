//
//  NetworkHelper.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

class Networker {
    static var shared = Networker()

    func makeGetRequest<T: Decodable>(session: URLSession = URLSession.shared, url: String,
                                      completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url  = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        let task = session.dataTask(with: url) { (data, response, _) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(genericModel))
                    } catch {
                        completion(.failure(.jsonConversionFailure))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }
        task.resume()
    }
}
