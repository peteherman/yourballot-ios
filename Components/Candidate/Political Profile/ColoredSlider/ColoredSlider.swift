//
//  ColoredSlider.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct ColoredSlider: View {
    @State private var sliderBarSize: CGSize = .zero
    var body: some View {
        VStack(spacing: 0) {
            Text("Issue")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.leading)
                .padding(.top, 3.0)
            ZStack {
                CustomSliderBar(color: .black)
                    .saveSize(in: $sliderBarSize)
            }
        }
        .background(Theme.light_blue.mainColor)
    }
}

#Preview {
    ColoredSlider()
}
