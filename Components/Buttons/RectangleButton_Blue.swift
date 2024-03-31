//
//  RectangularButton_Blue.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/31/24.
//

import SwiftUI

struct RectangleButton_Blue: View {
    let buttonText: String
    let onPress: () -> Void
    var body: some View {
        Button(action: onPress, label: {
            Text(buttonText)
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
}

#Preview {
    RectangleButton_Blue(buttonText: "Submit", onPress: {})
}
