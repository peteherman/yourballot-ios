//
//  GuestTrial.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import Foundation

class GuestTrial: ObservableObject, Encodable {
    
   

    var zipcode: String = ""
    var answeredQuestions: [IssueQuestion] = []    
    let zipRegex: Regex<Substring> = /^[0-9]{5}$/

    
    /*
     * Determines if self.zipcode is a valid 5 digit zipcode
     */
    var isZipcodeValid: Bool {
        print("Running here!")
        do {
            let result = try zipRegex.wholeMatch(in: self.zipcode)
            return result != nil
        } catch {
            print("Got error: \(error.localizedDescription)")
            return false
        }
    }
    
    /*
     * Initializer which is useful for tests/mocks/previews
     */
    init(zipcode: String = "", answeredQuestions: [IssueQuestion] = []) {
        self.zipcode = zipcode
        self.answeredQuestions = answeredQuestions
    }
    
    /*
     * Calculates aggregate issue view scores
     */
    func computeIssueViews() -> IssueViewsSummary {
        var issueViews: Dictionary<String, Double> = [:]
        var aggregateViews: Dictionary<String, Dictionary<String, Double>> = [:]
        for question in self.answeredQuestions {
            if !aggregateViews.keys.contains(question.issue_name) {
                aggregateViews[question.issue_name] = [ "sum": 0.0, "count": 0.0 ]
            }
            aggregateViews[question.issue_name]!["sum"]! += question.rating ?? 0.0
            aggregateViews[question.issue_name]!["count"]!  += 1.0
        }
        for issue_key in aggregateViews.keys {
            issueViews[issue_key] = aggregateViews[issue_key]!["sum"]! / aggregateViews[issue_key]!["count"]!
        }
        return issueViews
    }
    
    /*
     * Answers a question by appending this question to self.answeredQuestions
     */
    func answerQuestion(question: IssueQuestion) -> Void {
        self.answeredQuestions.append(question)
    }
        
    private enum CodingKeys: String, CodingKey {
        case zipcode
        case issue_views
    }
    
    /*
     * For encoding guestTrial into data to be sent to API to get candidate matches
     */
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.zipcode, forKey: .zipcode)
        try container.encode(self.computeIssueViews(), forKey: .issue_views)
    }
    

}
