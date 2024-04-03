//
//  ColoredSlider.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct ColoredSlider: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Issue")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.leading)
                .padding(.top, 3.0)
            ZStack {
                CustomSliderBar(color: .black)
                Circle()
                    .stroke(Theme.red_accent.mainColor, lineWidth: 3.0)
                    .background(Circle().foregroundColor(Theme.light_red.mainColor))
                    .frame(width: 30)
            }
        }
        .background(Theme.light_blue.mainColor)
    }
}

#Preview {
    ColoredSlider()
}
