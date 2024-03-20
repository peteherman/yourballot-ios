//
//  BaseResponse.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/20/24.
//

import Foundation

struct BaseResponse: Decodable {
    public enum RootCodingKeys: String, CodingKey {
        case result_info
        case result
    }
    
    public enum PaginationCodingKeys: String, CodingKey {
        case next
        case previous
        case total
    }
}
