//
//  ApiError.swift
//  Weather
//
//  Created by Godwin Olorunshola on 12/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURL, requestFailed, jsonConversionFailure, invalidData, responseUnsuccessful
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "There was an issue with the request url"
        case .requestFailed:
            return "An error occured, please check Internet Connection"
        case .jsonConversionFailure:
            return "The model decoding failed, please check model."
        case .invalidData:
            return "Data corrupted"
        case .responseUnsuccessful:
            return "There was a error, request not successful, please check server response."
        }
    }
}
