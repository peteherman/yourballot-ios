//
//  GuestQuestionView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct GuestQuestionView: View {
    @State var responseValue: Double
    let maxResponseValue: Double
    @StateObject var questionService: GuestQuestionService
    @StateObject var guestTrial: GuestTrial
    
    func resetSlider() {
        self.responseValue = maxResponseValue / 2
    }
    
    // Score question, save to local data, and update current question
    func submitQuestion() {
        guard questionService.currentQuestion != nil else { return }
        Task {
            var question = questionService.currentQuestion!
            question.rating = responseValue
            try await questionService.answerQuestion(question: question)
        }
        self.resetSlider()
    }
    
    
    @ViewBuilder
    var body: some View {
        if questionService.currentQuestion != nil && guestTrial.answeredQuestions.count == 0 {
            VStack {
                Text(questionService.currentQuestion!.question)
                    .padding([.top, .leading, .trailing])
                    .multilineTextAlignment(.center)
                    .font(.title2)
                Spacer()
                Slider_Draggable(value: $responseValue, maxValue: maxResponseValue)
                    .cornerRadius(10.0)
                    .padding([.leading, .trailing])
                HStack {
                    RectangleButton_Blue(buttonText: "Submit", onPress: submitQuestion)
                }
                .padding([.leading, .trailing])
            }
            .padding(.top)
        } else if questionService.answeredAllQuestions && guestTrial.answeredQuestions.count > 0 {
            // Answered all questions, time to get results
            NavigationView {
                VStack {
                    Text("Questions Complete")
                        .font(.title2)
                    Spacer()
                        .frame(maxHeight: 120)
                    NavigationLink(destination: GuestMatchesView(guestQuestionService: questionService, guestTrial: guestTrial)) {
                        RectangleButton_Blue(buttonText: "Get Results", onPress: submitQuestion)
                    }
                }
            }
            
        } else {
            // Still need to fetch questions
            Text("Loading Questions")
        }
    }
}

struct GuestQuestionView_Preview: PreviewProvider {
    
    static var mockQuestionProvider = MockQuestionProvider()
    static var guestQuestionService = GuestQuestionService(currentQuestion: IssueQuestion.sampleData[0], provider: mockQuestionProvider)

    
    static var guestTrial = GuestTrial(zipcode: "12831")
    
//    static var previews: some View {
//        GuestQuestionView(responseValue: 5.0, maxResponseValue: 10.0, questionService: guestQuestionService, guestTrial: guestTrial)
//    }
    
    static var guestTrialFullyAnswered = GuestTrial(zipcode: "12831", answeredQuestions: [
        IssueQuestion(id: 1, issue_name: "Immmigration", external_id: UUID(), question: "The federal government should more heavily restrict who is allowed through the border", rating: 2.0),
        IssueQuestion(id: 2, issue_name: "Abortion", external_id: UUID(),
                      question: "Abortion is murder", rating: 0.0)
    ])
    
    static var questionServiceFullyAnswered = GuestQuestionService(questions: [], provider: mockQuestionProvider)
    static var previews: some View {
        GuestQuestionView(responseValue: 5.0, maxResponseValue: 10.0, questionService: questionServiceFullyAnswered, guestTrial: guestTrialFullyAnswered)
    }
}
