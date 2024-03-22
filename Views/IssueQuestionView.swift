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
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Skip")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing])
                })
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Theme.light_red.mainColor)
                .cornerRadius(10.0)
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Theme.light_red_accent.mainColor, lineWidth: 2)
                )
                .padding(.bottom)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing])
                })
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Theme.light_blue.mainColor)
                .cornerRadius(10.0)
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Theme.light_blue_accent.mainColor, lineWidth: 2)
                )
                .padding(.bottom)

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
