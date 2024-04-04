//
//  ColoredSlider.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct ColoredSlider: View {
    @State private var sliderFrame: CGRect = .zero
    
    func circlePositionOnSlider(ratingPercentage: Double) -> CGPoint {
        let midpoint = sliderFrame.midX
        let xPosition = midpoint + (ratingPercentage - 0.5) * sliderFrame.width
        return CGPoint(x: xPosition, y: sliderFrame.midY)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Issue")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding([.leading, .top])
            CustomSliderBar(color: .black)
                .saveFrame(in: $sliderFrame)
                .overlay(Circle()
                    .fill(.red)
                    .frame(width: 30)
                    .position(circlePositionOnSlider(ratingPercentage: 0.5))
                )
                .padding(.bottom)
        }
        .background(Theme.light_blue.mainColor)
    }
}

#Preview {
    ColoredSlider()
}
