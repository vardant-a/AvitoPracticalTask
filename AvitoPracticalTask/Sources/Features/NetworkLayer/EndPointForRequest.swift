//
//  EndPointForRequest.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 28.08.2023.
//

import UIKit

enum EndPointForRequest {
    case getAllItems
    case getDetails(itemId: String)
}

extension EndPointForRequest: EndPoint {
    var scheme: String {
        switch self {
        case .getAllItems, .getDetails(itemId: _):
           return Scheme.secure
        }
    }
    
    var host: String {
        switch self {
        case .getAllItems, .getDetails(itemId: _):
            return Host.avito
        }
    }
    
    var path: String {
        switch self {
        case .getAllItems:
            return Path.main.value
        case .getDetails(let itemId):
            return Path.details(itemId: itemId).value
        }
    }
}
