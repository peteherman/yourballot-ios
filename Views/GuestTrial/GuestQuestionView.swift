//
//  GuestQuestionView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct GuestQuestionView: View {
    @StateObject var questionService: GuestQuestionService
    let zipcode: String
    @State var responseValue: Double = 5.0
    @State var answeredQuestions: [IssueQuestion] = []
    let maxResponseValue: Double = 10.0
    
    
    var body: some View {
        if answeredQuestions.count == 0 && questionService.currentQuestion == nil {
            GuestQuestionView_Loading(questionService: questionService)
        } else if questionService.currentQuestion != nil {
            GuestQuestionView_AnswerQuestion(questionService: questionService, answeredQuestions: $answeredQuestions, responseValue: $responseValue, maxResponseValue: maxResponseValue, zipcode: zipcode)
        } else if questionService.answeredAllQuestions && answeredQuestions.count > 0 {
            GuestQuestionView_QuestionsCompleted(questionService: questionService, zipcode: zipcode, answeredQuestions: answeredQuestions)
        }
    }
}

struct GuestQuestionView_Loading: View {
    @ObservedObject var questionService: GuestQuestionService

    var body: some View {
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
    }
}

struct GuestQuestionView_AnswerQuestion: View {
    @ObservedObject var questionService: GuestQuestionService
    @Binding var answeredQuestions: [IssueQuestion]
    @Binding var responseValue: Double
    let maxResponseValue: Double
    let zipcode: String
    
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
            answeredQuestions.append(question)
        }
        self.resetSlider()
    }
    
    
    var body: some View {
        if (questionService.currentQuestion != nil) {
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
                    RectangleButton_Blue(buttonText: "Submit", onPress: {
                        self.submitQuestion()
                    })
                }
                .padding([.leading, .trailing])
            }
            .padding(.top)
            .toolbar(.hidden)
        } else {
            GuestQuestionView_QuestionsCompleted(questionService: questionService, zipcode: zipcode, answeredQuestions: answeredQuestions)
        }
    }
}
    
struct GuestQuestionView_QuestionsCompleted: View {
    @ObservedObject var questionService: GuestQuestionService
    let zipcode: String
    let answeredQuestions: [IssueQuestion]
    var body: some View {
        VStack {
            Text("Questions Complete")
                .font(.title2)
            Spacer()
                .frame(maxHeight: 120)
            NavigationLink(destination: GuestMatchesView(guestQuestionService: questionService, zipcode: zipcode, answeredQuestions: answeredQuestions)) {
                RectangularView_Blue(buttonText: "Get Results")
            }
        }
        .toolbar(.hidden)
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
        GuestQuestionView(questionService: guestQuestionService, zipcode: "12381")
    }
}
