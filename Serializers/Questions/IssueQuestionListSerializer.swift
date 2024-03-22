//
//  IssueQuestionListSerializer.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/20/24.
//

import Foundation

class IssueQuestionListSerializer: BaseSerializer {
    private(set) var issueQuestions: [IssueQuestion] = []
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let _ = try rootContainer.nestedContainer(keyedBy: PaginationCodingKeys.self, forKey: RootCodingKeys.result_info)
        var issueQuestionsContainer = try rootContainer.nestedUnkeyedContainer(forKey: RootCodingKeys.result)
        
        while !issueQuestionsContainer.isAtEnd {
            if let issueQuestion = try? issueQuestionsContainer.decode(IssueQuestion.self) {
                issueQuestions.append(issueQuestion)
            }
            
        }
    }
}
