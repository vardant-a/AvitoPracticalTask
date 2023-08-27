//
//  AdvertisementsResponse.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 26.08.2023.
//

import Foundation

struct AdvertisementsResponse: Codable {
    var advertisements: [Advertisement]?
}

struct Advertisement: Codable {
    var id: String?
    var title: String?
    var price: String?
    var location: String?
    var imageUrl: String?
    var createdDate: String?
    var description: String?
    var email: String?
    var phoneNumber: String?
    var address: String?

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case description, email, address
        case imageUrl = "image_url"
        case createdDate = "created_date"
        case phoneNumber = "phone_number"
    }
}
