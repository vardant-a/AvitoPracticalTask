//
//  RequestError.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import Foundation

enum RequestError: String, Error {
    case invalidURL
    case dataNotReceived
    case decodeError
    
    var message: String {
        switch self {
        case .invalidURL:
            return Localizable.Request.Message.invalidURL
        case .dataNotReceived:
            return Localizable.Request.Message.dataNotReceived
        case .decodeError:
            return Localizable.Request.Message.decodeError
        }
    }
}
