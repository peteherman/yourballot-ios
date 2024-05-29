//
//  ResultInfoSerializer.swift
//  Your BallotTests
//
//  Created by Peter Herman on 5/29/24.
//

import Foundation

class ResultInfoSerializer: BaseSerializer {
    var resultInfo: ResultInfo = ResultInfo(next: nil, previous: nil, success: false, errors: [])
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let resultInfoDecoded = try rootContainer.decode(ResultInfo.self, forKey: RootCodingKeys.result_info)
        resultInfo = resultInfoDecoded
    }
}
