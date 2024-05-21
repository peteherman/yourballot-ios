//
//  ProviderCore.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/19/24.
//

import Foundation
import OSLog

let environment = ProcessInfo.processInfo.environment

let API_BASE = environment["API_BASE_URI"] ?? "http://localhost:8080"

let validStatus = 200...299

protocol HTTPProvider {
    func getHttp(from url: URL) async throws -> Data
    func postHttp(data message: Encodable, to url: URL) async throws -> Data
}

extension URLSession: HTTPProvider {
    
    func getHttp(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw APIError.unexpectedError(error: "Received unknown error")
        }
        return data
    }
    
    func postHttp(data message: Encodable, to url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try encoder.encode(message)
        if let str = String(data: data, encoding: .utf8) {
            print("Post Data: \(str)")
        }

        let (responseData, response) = try await self.upload(for: request, from: data)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
            return responseData
        } else {
            let logger = Logger()
            logger.debug("Received non-200 response from API on POST request. Status: \(httpResponse.statusCode)")
            if let str = String(data: responseData, encoding: .utf8) {
                logger.debug("Response Data: \(str)")
            }
            let error = NSError(domain: "UploadError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
            throw error
        }
    }
}
