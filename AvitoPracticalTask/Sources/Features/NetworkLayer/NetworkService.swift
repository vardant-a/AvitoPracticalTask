//
//  NetworkService.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 25.08.2023.
//

import Foundation

protocol NetworkService: RequestService {
    func fetchAllData() async -> Result<AdvertisementsResponse, RequestError>
    func fetchDetails(itemId: String) async -> Result<Advertisement, RequestError>
    func fetchImage(_ urlString: String) async -> Result<Data, RequestError>
}

struct NetworkManager: NetworkService {
    func fetchAllData() async -> Result<AdvertisementsResponse, RequestError> {
        return await fetch(
            EndPointForRequest.getAllItems,
            model: AdvertisementsResponse.self)
    }
    func fetchDetails(itemId: String) async -> Result<Advertisement, RequestError> {
        return await fetch(EndPointForRequest.getDetails(itemId: itemId), model: Advertisement.self)
    }

    func fetchImage(_ urlString: String) async -> Result<Data, RequestError> {
        return await fetchImageContent(urlString)
    }
}
