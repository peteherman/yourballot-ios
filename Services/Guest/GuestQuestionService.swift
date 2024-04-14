//
//  GuestQuestionService.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import Foundation

@MainActor
class GuestQuestionService: ObservableObject {
    // TODO: Add cache
    private let getQuestionsURL = URL(string: "\(API_BASE)/v1/guest/questions/")!
    private let decoder: JSONDecoder = JSONDecoder()
    private let provider: any HTTPProvider
    @Published var currentQuestion: IssueQuestion?
    private var questionQueue: [IssueQuestion] = []
    
    var answeredAllQuestions: Bool {
        return currentQuestion == nil && questionQueue.count == 0
    }
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    /*
     * Initializer useful for mocks/testing/previews
     */
    init(questions: [IssueQuestion] = [], currentQuestion: IssueQuestion? = nil, provider: any HTTPProvider = URLSession.shared) {
        self.questionQueue = questions
        self.currentQuestion = currentQuestion
        self.provider = provider
    }
    
    func fetchQuestions() async throws {
        let task = Task<[IssueQuestion], Error> {
            let questionData = try await provider.getHttp(from: getQuestionsURL)
            let issueQuestionListSerializer = try decoder.decode(IssueQuestionListSerializer.self, from: questionData)
            return issueQuestionListSerializer.issueQuestions
        }
        let issueQuestions = try await task.value
        self.questionQueue = issueQuestions
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
//        let task = Task {
//            let encoder = JSONEncoder()
//            let encodedQuestion = try encoder.encode(question)
//            let _ = try await provider.postHttp(data: encodedQuestion, to: answerQuestionURL)
//        }
//        _ = try await task.value
        self.currentQuestion = self.popFirstQuestion()
    }
    
    // Primarily for testing purposes. No need for a view to access this
    func getQuestionQueue() -> [IssueQuestion] {
        return self.questionQueue
    }
}
