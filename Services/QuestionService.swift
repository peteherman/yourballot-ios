//
//  QuestionService.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/20/24.
//

import Foundation

class QuestionService {
    // TODO: Add cache
    private let remainingQuestionsURL = URL(string: "\(API_BASE)/v1/voter/questions.remaining")!
    private let answerQuestionURL = URL(string: "\(API_BASE)/v1/voter/questions")!
    private let decoder: JSONDecoder = JSONDecoder()
    private let provider: any HTTPProvider
    
    private var questionQueue: [IssueQuestion] = []
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    func fetchQuestions() async throws {
        let questionData = try await provider.getHttp(from: remainingQuestionsURL)
        let issueQuestionListSerializer = try decoder.decode(IssueQuestionListSerializer.self, from: questionData)
        questionQueue = issueQuestionListSerializer.issueQuestions
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
        let encoder = JSONEncoder()
        let encodedQuestion = try encoder.encode(question)
        let answerResponse = try await provider.postHttp(data: encodedQuestion, to: answerQuestionURL)
    }
    
    // Primarily for testing purposes. No need for a view to access this
    func getQuestionQueue() -> [IssueQuestion] {
        return self.questionQueue
    }
}
