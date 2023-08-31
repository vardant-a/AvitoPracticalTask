//
//  Localizable.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 31.08.2023.
//

import Foundation

enum Localizable {
    enum Element {
        static let tabAdvertisement = NSLocalizedString("Element.TabAdvertisement", comment: "")
        static let callButton = NSLocalizedString("Element.CallButton", comment: "")
        static let descriptionLabel = NSLocalizedString("Element.Description", comment: "")
    }
    
    enum Request {
        enum Message {
            static let invalidURL = NSLocalizedString("Request.Message.InvalidURL", comment: "")
            static let dataNotReceived = NSLocalizedString("Request.Message.DataNotReceived", comment: "")
            static let decodeError = NSLocalizedString("Request.Message.DecodeError", comment: "")
        }
    }
    
    enum AlertAction {
        static let now = NSLocalizedString("AlertAction.Now", comment: "")
        static let later = NSLocalizedString("AlertAction.Later", comment: "")
        static let settings = NSLocalizedString("AlertAction.Settings", comment: "")
        static let share = NSLocalizedString("AlertAction.Share", comment: "")
        static let showDetail = NSLocalizedString("AlertAction.ShowDetail", comment: "")
        static let cancel = NSLocalizedString("AlertAction.Cancel", comment: "")
        static let delete = NSLocalizedString("AlertAction.Delete", comment: "")
    }
}


