//
//  RectangleButton+Color.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/31/24.
//

import SwiftUI

struct RectangleButton_Red: View {
    let buttonText: String
    let onPress: () -> Void
    var disabled: Bool = false
    
    var body: some View {
        Button(action: onPress, label: {
            Text(buttonText)
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
        .disabled(disabled)
    }
}

#Preview {
    RectangleButton_Red(buttonText: "Skip", onPress: {})
}
