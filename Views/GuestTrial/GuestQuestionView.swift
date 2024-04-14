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
                    Text("Get Results")
                        .font(.title2)
                    NavigationLink(destination: GuestMatchesView()) {
                        RectangleButton_Blue(buttonText: "Submit", onPress: submitQuestion)
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
    
    static var previews: some View {
        GuestQuestionView(responseValue: 5.0, maxResponseValue: 10.0, questionService: guestQuestionService, guestTrial: guestTrial)
    }
}
