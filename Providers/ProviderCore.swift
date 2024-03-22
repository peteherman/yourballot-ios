//
//  ProviderCore.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/19/24.
//

import Foundation

let API_BASE = "http://localhost:8080"

let validStatus = 200...299

protocol HTTPProvider {
    func getHttp(from url: URL) async throws -> Data
    func postHttp(data message: Codable, to url: URL) async throws -> Data
}

extension URLSession: HTTPProvider {
    func getHttp(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw APIError.unexpectedError(error: "Received unknown error")
        }
        return data
    }
    
    func postHttp(data message: Codable, to url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try encoder.encode(message)
        request.httpBody = data

        guard let (responseData, response) = try await self.upload(for: request, from: data, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
                  throw APIError.unexpectedError(error: "Received unknown")
        }
        return data
    }
}
