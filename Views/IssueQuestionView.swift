//
//  IssueQuestion.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/18/24.
//

import SwiftUI

struct IssueQuestionView: View {
    @State var responseValue: Double
    let maxResponseValue: Double
    @StateObject var questionService: QuestionService
    
    // Score question, submit to api, and update current question
    func submitQuestion() {
        guard questionService.currentQuestion != nil else { return }
        Task {
            var question = questionService.currentQuestion!
            question.rating = responseValue
            try await questionService.answerQuestion(question: question)
        }
    }
    
    func skipQuestion() {
        guard questionService.currentQuestion != nil else { return }
        let question = questionService.currentQuestion!
        questionService.skipQuestion(question: question)
    }
    
    @ViewBuilder
    var body: some View {
        if questionService.currentQuestion != nil {
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
                    RectangleButton_Red(buttonText: "Skip", onPress: submitQuestion)
                    RectangleButton_Blue(buttonText: "Submit", onPress: skipQuestion)
                }
                .padding([.leading, .trailing])
            }
            .padding(.top)
        }
        else {
            Text("No more questions at this time")
        }
    }
}

struct IssueQuestionView_Preview : PreviewProvider {
    static let maxValue: Double = 10.0
    static var value: Double = 5.0
    static var questionProvider: any HTTPProvider = MockQuestionProvider()
    static var questionService = QuestionService(provider: questionProvider)
    static var previews: some View {
        IssueQuestionView(responseValue: value, maxResponseValue: maxValue, questionService: questionService)
    }
}
