//
//  NetworkHelper.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

protocol ApiClient {
    func execute<T: Decodable>(request: ApiRequest,
                               completion: @escaping (Result<T, Error>) -> Void)
}

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class APIClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared ) {
        self.urlSession =  urlSession
    }

    func execute<T: Decodable>(request: ApiRequest,
                               completion: @escaping (Result<T, Error>) -> Void) {
        let task = urlSession.dataTask(with: request.urlRequest) { (data, response, _) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(genericModel))
                    } catch {
                        completion(.failure(APIError.jsonConversionFailure))
                    }
                } else {
                    completion(.failure(APIError.invalidData))
                }
            } else {
                completion(.failure(APIError.responseUnsuccessful))
            }
        }
        task.resume()
    }
}
