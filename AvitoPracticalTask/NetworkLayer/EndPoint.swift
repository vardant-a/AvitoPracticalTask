//
//  EndPoint.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 27.08.2023.
//

import Foundation

protocol EndPoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
}

enum Scheme {
    static let basic = "http"
    static let secure = "https"
}

enum Host {
    static let avito = "www.avito.st"
}

enum Path {
    case main
    case details(itemId: String)
    
    var value: String {
        switch self {
        case .main:
            return "/s/interns-ios/main-page.json"
        case .details(let itemId):
            return "/s/interns-ios/details/\(itemId).json"
        }
    }
}
