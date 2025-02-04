//
//  BaseResponse.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/20/24.
//

import Foundation

class BaseSerializer: Decodable {
    public enum RootCodingKeys: String, CodingKey {
        case result_info
        case result
    }
    public enum PaginationCodingKeys: String, CodingKey {
        case next
        case previous
        case total
        case success
        case errors
    }
}
