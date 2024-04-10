//
//  Your_BallotTests.swift
//  Your BallotTests
//
//  Created by Peter Herman on 3/17/24.
//

import XCTest
@testable import Your_Ballot

final class QuestionServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchResponseWithNoCurrentQuestions() async throws {
        // Tests that the question provider will receive questions when querying api for questions without any
        // starting questions
        let provider = MockQuestionProvider()
        let questionService = await QuestionService(provider: provider)
        
        try await questionService.fetchQuestions()
        for _ in 1...10 {
            let question: IssueQuestion? = await questionService.popFirstQuestion()
            XCTAssert(question != nil)
        }
        let question: IssueQuestion? = await questionService.popFirstQuestion()
        XCTAssertEqual(question, nil)
    }
    
    func testPopFirstQuestionNoQuestions() async {
        // Test that the question provider returns nil when popping from an empty queue
        let provider = MockQuestionProvider()
        let questionService = await QuestionService(provider: provider)
        let firstQuestion = await questionService.popFirstQuestion()
        XCTAssertEqual(firstQuestion, nil)
    }
    
    func testReplaceQuestionPlacesQuestionAtFrontOfQueue() async throws {
        // Test replaceQuestion places question at front of queue
        let provider = MockQuestionProvider()
        let questionService = await QuestionService(provider: provider)
        
        try await questionService.fetchQuestions()
        var questionQueue = await questionService.getQuestionQueue()
        XCTAssertEqual(questionQueue.count, 10)
        
        let firstQuestion: IssueQuestion? = await questionService.popFirstQuestion()
        XCTAssertNotNil(firstQuestion)
        questionQueue = await questionService.getQuestionQueue()
        XCTAssertEqual(questionQueue.count, 9)
        await questionService.replaceQuestion(question: firstQuestion!)
        questionQueue = await questionService.getQuestionQueue()
        XCTAssertEqual(questionQueue[0], firstQuestion)
    }
    
    func testPostAnswerSuccess() async throws {
        // Test replaceQuestion places question at front of queue
        let provider = MockQuestionProvider()
        let questionService = await QuestionService(provider: provider)
        let decoder = JSONDecoder()
        let issueQuestionListSerializer = try decoder.decode(IssueQuestionListSerializer.self, from: testVoterRemainingQuestionsData)
        var testQuestion = issueQuestionListSerializer.issueQuestions[0]
        testQuestion.rating = 5.0
        try await questionService.answerQuestion(question: testQuestion)
    }
    
}
