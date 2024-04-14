//
//  RectangularView+Blue.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

import SwiftUI

struct RectangularView_Blue: View {
    let buttonText: String
    var body: some View {
        HStack {
            Text(buttonText)
                .font(.headline)
                .foregroundColor(.black)
                .padding([.leading, .trailing])
        }
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
    RectangularView_Blue(buttonText: "Submit")
}
