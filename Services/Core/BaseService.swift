//
//  BaseService.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/30/24.
//

import Foundation

class BaseService {
    private let HTTP_OK = [ 200, 201 ]
    
    func requestSuccessful(_ response: HTTPURLResponse) -> Bool {
        return HTTP_OK.contains(response.statusCode)
    }
    
    func parseErrorMessageFromResponseData(_ responseData: Data) throws -> String {
        // Decode the response data now
        let decoder = JSONDecoder()
        let resultInfoSerializer = try decoder.decode(ResultInfoSerializer.self, from: responseData)
        let results = resultInfoSerializer.resultInfo
        
        let joinedErrorMessages = results.errors.joined(separator: ", ")
        return joinedErrorMessages
    }
}
