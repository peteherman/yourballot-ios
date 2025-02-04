//
//  Slider+Draggable.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/18/24.
//

import SwiftUI

struct Slider_Draggable: View {
    @Binding var value: Double
    let maxValue: Double
    var body: some View {
        VStack {
            Slider(
                value: $value,
                in: 0...maxValue
            )
            .accentColor(.black)
            HStack {
                Text("Strongly Disagree")
                    .frame(alignment: .leading)
                Spacer()
                Text("Strongly Agree")
                    .frame(alignment: .trailing)
            }
        }
        .padding()
        .background(Theme.light_gray.mainColor)
    }
}

#Preview {
    Slider_Draggable(value: .constant(5.0), maxValue: 10.0)
}
