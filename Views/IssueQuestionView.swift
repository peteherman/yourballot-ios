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
    let issueQuestion: IssueQuestion
    
    
    
    var body: some View {
        VStack {
            Text(issueQuestion.question)
                .padding([.top, .leading, .trailing])
                .multilineTextAlignment(.center)
                .font(.title2)
            Spacer()
            Slider_Draggable(value: $responseValue, maxValue: maxResponseValue)
                .cornerRadius(10.0)
                .padding([.leading, .trailing])
            HStack {
                RectangleButton_Red(buttonText: "Skip", onPress: {})
                RectangleButton_Blue(buttonText: "Submit", onPress: {})
            }
            .padding([.leading, .trailing])
        }
        .padding(.top)
    }
}

struct IssueQuestionView_Preview : PreviewProvider {
    static let maxValue: Double = 10.0
    static var value: Double = 5.0
    static var previews: some View {
        IssueQuestionView(responseValue: value, maxResponseValue: maxValue, issueQuestion: IssueQuestion.sampleData[0])
    }
}
