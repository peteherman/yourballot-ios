//
//  IssueQuestion.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/18/24.
//

import Foundation

struct IssueQuestion: Decodable, Equatable, Encodable {
    let id: Int64
    let issue_name: String
    let external_id: UUID
    let question: String
    var rating: Double?
}

extension IssueQuestion {
    static let sampleData: [IssueQuestion] =
    [
        IssueQuestion(id: 5, issue_name: "Immigration", external_id: UUID(uuidString: "44e177f5-2334-46e4-9c08-6579f5483309")!, question: "The federal government should more heavily restrict who is allowed through the border")
    ]
}

extension IssueQuestion {
    static func ==(lhs: IssueQuestion, rhs: IssueQuestion) -> Bool {
        return lhs.id == rhs.id
    }
}
