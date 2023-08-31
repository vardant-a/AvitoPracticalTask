//
//  RequestService.swift
//  AvitoPracticalTask
//
//  Created by Aleksei on 31.08.2023.
//

import Foundation

protocol RequestService {
    func fetch<T: Decodable>(_ endPoint: EndPoint, model: T.Type
    ) async -> Result<T, RequestError>
    
    func fetchImageContent(_ urlString: String
    ) async -> Result<Data, RequestError>
}

extension RequestService {
    func fetch<T: Decodable>(_ endPoint: EndPoint, model: T.Type
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path
        guard let url = urlComponents.url else {
            return .failure(RequestError.invalidURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared
                .data(from: url)
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodeData)
            } catch {
                return.failure(RequestError.decodeError)
            }
        } catch {
            return .failure(RequestError.dataNotReceived)
        }
    }

    func fetchImageContent(_ urlString: String) async -> Result<Data, RequestError> {
        guard let url = URL(string: urlString) else {
            return .failure(RequestError.invalidURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return .success(data)
        } catch {
            return .failure(RequestError.dataNotReceived)
        }
    }
}
