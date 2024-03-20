//
//  IssueQuestion.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/18/24.
//

import SwiftUI

struct IssueQuestion: View {
    @State var responseValue: Double
    let maxResponseValue: Double
    
    
    var body: some View {
        VStack {
            Text("Here is some question")
                .padding([.top, .leading, .trailing])
            Spacer()
            Slider_Draggable(value: $responseValue, maxValue: maxResponseValue)
                .cornerRadius(10.0)
                .padding([.leading, .trailing])
        }
    }
}

struct IssueQuestion_Preview : PreviewProvider {
    static let maxValue: Double = 10.0
    static var value: Double = 5.0
    static var previews: some View {
        IssueQuestion(responseValue: value, maxResponseValue: maxValue)
    }
}
