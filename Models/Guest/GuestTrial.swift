//
//  GuestTrial.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import Foundation

@MainActor
class GuestTrial: ObservableObject {
    var zipcode: String = ""
    var answeredQuestions: [IssueQuestion] = []    
    
    /*
     * Initializer which is useful for tests/mocks/previews
     */
    init(zipcode: String = "", answeredQuestions: [IssueQuestion] = []) {
        self.zipcode = zipcode
        self.answeredQuestions = answeredQuestions
    }
}
