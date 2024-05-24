//
//  AuthResponseSerializer.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation

class AuthResponseSerializer: BaseSerializer {
    var authTokens: AuthTokens?
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let _ = try rootContainer.nestedContainer(keyedBy: PaginationCodingKeys.self, forKey: RootCodingKeys.result_info)
        let authTokenResponse = try rootContainer.decode(AuthTokenResponse.self, forKey: RootCodingKeys.result)
        authTokens = AuthTokens(access: authTokenResponse.access, refresh: authTokenResponse.refresh, createdAt: Date())
    }
}
