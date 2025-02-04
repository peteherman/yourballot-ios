//
//  QuestionService.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/20/24.
//

import Foundation
import OSLog

@MainActor
class QuestionService: ObservableObject {
    // TODO: Add cache
    private let remainingQuestionsURL = URL(string: "\(API_BASE)/v1/voter/questions.remaining/")!
    private let answerQuestionURL = URL(string: "\(API_BASE)/v1/voter/questions/")!
    private let decoder: JSONDecoder = JSONDecoder()
    private let provider: any HTTPProvider
    private let voterAuthService: VoterAuthService
    @Published var currentQuestion: IssueQuestion?
    private let logger: Logger = Logger()
    
    private var questionQueue: [IssueQuestion] = []
    private var skippedQuestions: [IssueQuestion] = []
    
    init(provider: any HTTPProvider = URLSession.shared, voterAuthService: VoterAuthService? = nil) {
        self.provider = provider
        if voterAuthService != nil {
            self.voterAuthService = voterAuthService!
        } else {
            self.voterAuthService = VoterAuthService(provider: insecure_provider())
        }
    }
    
    func fetchQuestions() async throws {
        let task = Task<[IssueQuestion], Error> {
            logger.debug("Fetching voter's remaining questions")
            let authTokens = try await self.voterAuthService.getTokensForAuthenticatedRequest()
            let questionData = try await provider.authenticatedGetHttp(from: remainingQuestionsURL, accessToken: authTokens.access)
            let issueQuestionListSerializer = try decoder.decode(IssueQuestionListSerializer.self, from: questionData)
            let receivedQuestions = issueQuestionListSerializer.issueQuestions
            logger.debug("Received issue questions: \(receivedQuestions)")
            return receivedQuestions
        }
        let issueQuestions = try await task.value
        self.questionQueue = issueQuestions
    }
    
    func initializeQuestions() async throws {
        try await self.fetchQuestions()
        self.currentQuestion = self.popFirstQuestion()
    }
    
    func popFirstQuestion() -> IssueQuestion? {
        guard questionQueue.count > 0 else { return nil }
        return questionQueue.removeFirst()
    }
    
    func replaceQuestion(question: IssueQuestion) {
        questionQueue.insert(question, at: 0)
    }
    
    /*
     * Answer a question by posting the question and it's response to the
     * API
     * @param question should contain an IssueQuestion where .rating != nil
     */
    func answerQuestion(question: IssueQuestion) async throws {
        let task = Task {
            let questionAnswerBody: [String: Double] = ["issue_question": Double(question.id), "rating": question.rating ?? 5.0]
            let authTokens = try await self.voterAuthService.getTokensForAuthenticatedRequest()
            let _ = try await provider.authenticatedPostHttp(data: questionAnswerBody, to: answerQuestionURL, accessToken: authTokens.access)
        }
        _ = try await task.value
        self.currentQuestion = self.popFirstQuestion()
    }
    
    // Primarily for testing purposes. No need for a view to access this
    func getQuestionQueue() -> [IssueQuestion] {
        return self.questionQueue
    }
    
    func skipQuestion(question: IssueQuestion) {
        self.skippedQuestions.append(question)
        self.currentQuestion = self.popFirstQuestion()
    }
}
