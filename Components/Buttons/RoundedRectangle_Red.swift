//
//  RoundedRectangle_Blue.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/21/24.
//

import SwiftUI

struct RoundedRectangle_Red: View {
    let buttonText: String
    
    var body: some View {
        VStack{
            Text(buttonText)
                .font(.headline)
                .foregroundColor(.black)
                .padding([.leading, .trailing])
        }
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .padding()
        .background(Theme.light_red.mainColor)
        .cornerRadius(10.0)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Theme.light_red_accent.mainColor, lineWidth: 2)
        )
        .padding(.bottom)
    }
}

#Preview {
    RoundedRectangle_Red(buttonText: "Hello world")
}
