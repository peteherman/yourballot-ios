//
//  GuestQuestionView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct GuestQuestionView: View {
    
}

struct GuestQuestion_LoadingView: ContentView {
    
}

struct GuestQuestionView: View {
    @StateObject var questionService: GuestQuestionService
//    @StateObject var guestTrial: GuestTrial
//    let zipcode: String
    @State var responseValue: Double = 5.0
    let maxResponseValue: Double = 10.0
    
    
    func resetSlider() {
        self.responseValue = maxResponseValue / 2
    }
    
//    // Score question, save to local data, and update current question
//    func submitQuestion() {
//        guard questionService.currentQuestion != nil else { return }
//        Task {
//            var question = questionService.currentQuestion!
//            question.rating = responseValue
//            try await questionService.answerQuestion(question: question)
//            guestTrial.answerQuestion(question: question)
//        }
//        self.resetSlider()
//    }
//    
    
    @ViewBuilder
    var body: some View {
        if guestTrial.answeredQuestions.count == 0 && questionService.currentQuestion == nil {
            // Still need to fetch questions
            Text("Loading Questions")
                .onAppear {
                    Task {
                        do {
                            try await questionService.fetchQuestions()
                            questionService.currentQuestion = questionService.popFirstQuestion()
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
                .toolbar(.hidden)
        }
        else if questionService.currentQuestion != nil {
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
                    RectangleButton_Blue(buttonText: "Submit", onPress: {})
                }
                .padding([.leading, .trailing])
            }
            .padding(.top)
            .toolbar(.hidden)
        } else if questionService.answeredAllQuestions && guestTrial.answeredQuestions.count > 0 {
            // Answered all questions, time to get results
            NavigationView {
                VStack {
                    Text("Questions Complete")
                        .font(.title2)
                    Spacer()
                        .frame(maxHeight: 120)
                    NavigationLink(destination: GuestMatchesView(guestQuestionService: questionService, guestTrial: guestTrial)) {
                        RectangularView_Blue(buttonText: "Get Results")
                    }
                }
            }
            .toolbar(.hidden)
            
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
        GuestQuestionView(questionService: questionServiceFullyAnswered, guestTrial: guestTrialFullyAnswered)
    }
}
