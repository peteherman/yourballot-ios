//
//  VoterProfileSerializer.swift
//  Your Ballot
//
//  Created by Peter Herman on 6/25/24.
//

import Foundation

class VoterProfileSerializer: BaseSerializer {
    var voter: Voter
    
    required init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let _ = try rootContainer.nestedContainer(keyedBy: PaginationCodingKeys.self, forKey: RootCodingKeys.result_info)
        let decodedVoter = try rootContainer.decode(Voter.self, forKey: RootCodingKeys.result)
        self.voter = decodedVoter
        try super.init(from: decoder)
    }
}
