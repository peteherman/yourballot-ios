//
//  Your_BallotApp.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/17/24.
//

import SwiftUI

@main
struct Your_BallotApp: App {
    @StateObject private var questionService = QuestionService(provider: MockQuestionProvider())
    var body: some Scene {
        WindowGroup {
//            IssueQuestionView(responseValue: 0.0, maxResponseValue: 5.0, questionService: questionService)
//                .task {
//                    do {
//                        try await questionService.fetchQuestions()
//                        questionService.currentQuestion = questionService.popFirstQuestion()
//                    } catch {
//                        print("Caught error", error.localizedDescription)
//                        fatalError(error.localizedDescription)
//                    }
//                }
            WelcomeView()
        }
    }
}
