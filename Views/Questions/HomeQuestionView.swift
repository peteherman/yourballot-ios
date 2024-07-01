//
//  HomeQuestionView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI

struct HomeQuestionView: View {
    @State var responseValue: Double
    let maxResponseValue: Double
    @StateObject var questionService: QuestionService
    @State private var loading: Bool = false
    @State private var errorMessage: String = ""
    
    func fetchQuestions() async -> Void {
        do {
            try await questionService.initializeQuestions()
            await MainActor.run {
                self.loading = false
            }
        } catch {
            print("Caught unexpected exception: \(error.localizedDescription)")
            await MainActor.run {
                self.errorMessage = "An unexpected error occurred. Please try again later"
                self.loading = false
            }
        }
    }
    
    func resetSlider() {
        self.responseValue = maxResponseValue / 2
    }
    
    // Score question, submit to api, and update current question
    func submitQuestion() {
        guard questionService.currentQuestion != nil else { return }
        Task {
            var question = questionService.currentQuestion!
            question.rating = responseValue
            try await questionService.answerQuestion(question: question)
        }
        self.resetSlider()
    }
    
    func skipQuestion() {
        guard questionService.currentQuestion != nil else { return }
        Task {
            let question = questionService.currentQuestion!
            questionService.skipQuestion(question: question)
        }
        self.resetSlider()
    }
    
    var loadingSpinner: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(2)  // Optional: scale to make it larger
            .padding()
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
                    RectangleButton_Red(buttonText: "Skip", onPress: skipQuestion)
                    RectangleButton_Blue(buttonText: "Submit", onPress: submitQuestion)
                }
                .padding([.leading, .trailing])
            }
            .padding(.top)
        }
        else if self.loading {
            loadingSpinner
                .task {
                    await fetchQuestions()
                }
        } else if self.errorMessage != "" {
            VStack {
                Text("\(self.errorMessage)")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
        else {
            Text("No more questions at this time")
                .task {
                    await fetchQuestions()
                }
        }
    }
}

struct HomeQuestionView_Preview : PreviewProvider {
    static let maxValue: Double = 10.0
    static var value: Double = 5.0
    static var questionProvider: any HTTPProvider = MockQuestionProvider()
    static var questionService = QuestionService(provider: questionProvider)
    static var previews: some View {
        HomeQuestionView(responseValue: value, maxResponseValue: maxValue, questionService: questionService)
    }
}
