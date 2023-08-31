//
//  StringValidationService.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 31.08.2023.
//

import Foundation

protocol StringValidatorService: AnyObject {
    func clearStringValue(_ value: String) -> String
}

final class StringValidator: StringValidatorService {
    // MARK: - Public Method
    
    func clearStringValue(_ value: String) -> String {
        let characterSet = CharacterSet(charactersIn: "0123456789")
        let clearedValue = value.components(separatedBy:characterSet.inverted)
            .joined()
            
        return clearedValue
    }

    // MARK: - Init

    init() {}
}
