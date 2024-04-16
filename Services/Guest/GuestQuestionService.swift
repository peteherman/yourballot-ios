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
    @Published var currentQuestion: IssueQuestion?
    @Published var candidateMatches: [Candidate] = []
    
    private let getQuestionsURL = URL(string: "\(API_BASE)/v1/guest/questions/")!
    private let getMatchesURL = URL(string: "\(API_BASE)/v1/guest/candidates/")!
    private let decoder: JSONDecoder = JSONDecoder()
    private let provider: any HTTPProvider
    private var questionQueue: [IssueQuestion] = []
    
    var answeredAllQuestions: Bool {
        return currentQuestion == nil && questionQueue.count == 0
    }
    
    /*
     * Initializer to use within views
     */
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    /*
     * Initializer useful for mocks/testing/previews
     */
    init(questions: [IssueQuestion] = [], currentQuestion: IssueQuestion? = nil, provider: any HTTPProvider = URLSession.shared, candidates: [Candidate] = []) {
        self.questionQueue = questions
        self.currentQuestion = currentQuestion
        self.provider = provider
        self.candidateMatches = candidates
    }
    
    /*
     * Fetches guest questions from the API. Decodes and stores response within self.questionQueue
     */
    func fetchQuestions() async throws {
        let task = Task<[IssueQuestion], Error> {
            let questionData = try await provider.getHttp(from: getQuestionsURL)
            let issueQuestionListSerializer = try decoder.decode(IssueQuestionListSerializer.self, from: questionData)
            return issueQuestionListSerializer.issueQuestions
        }
        let issueQuestions = try await task.value
        self.questionQueue = issueQuestions
    }
    
    /*
     * Pops the first question off of self.questionQueue and @returns it,
     * @returns nil if the queue is empty
     */
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
        self.currentQuestion = self.popFirstQuestion()
    }
    
    /*
     * Primarily for testing purposes. No need for a view to access this
     */
    func getQuestionQueue() -> [IssueQuestion] {
        return self.questionQueue
    }
    
    /*
     * Fetches Candidate matches from the API using @param guestTrial
     * to form the request body
     * Matches are stored within self.candidateMatches
     */
    func fetchMatches(guestTrial: GuestTrial) async throws {
        let task = Task<[Candidate], Error> {
            let postBody = try self.createPostBody(from: guestTrial)
            let candidateData = try await provider.postHttp(data: postBody, to: getMatchesURL)
            let candidateSerializer = try decoder.decode(VoterCandidatesSerializer.self, from: candidateData)
            return candidateSerializer.candidates
        }
        let matchedCandidates = try await task.value
        self.candidateMatches = matchedCandidates
    }
    
    
    func createPostBody(from guestTrial: GuestTrial) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(guestTrial)
    }
}
