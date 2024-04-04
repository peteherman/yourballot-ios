//
//  ColoredSlider.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct PoliticalIssueSlider: View {
    @State private var sliderFrame: CGRect = .zero
    let candidateRatingPercentage: Double
    let voterRatingPercentage: Double
    
    func circlePositionOnSlider(ratingPercentage: Double) -> CGPoint {
        let midpoint = sliderFrame.midX
        let xPosition = midpoint + (ratingPercentage - 0.5) * sliderFrame.width
        return CGPoint(x: xPosition, y: sliderFrame.midY)
    }
    
    func candidateCircle() -> some View {
        return sliderCircle(color: .blue, rating: candidateRatingPercentage)
    }
    
    func voterCircle() -> some View {
        return sliderCircle(color: .white, rating: voterRatingPercentage)
    }
    
    func sliderCircle(color: Color, rating: Double) -> some View {
        return Circle()
            .fill(color)
            .frame(width: 30)
            .position(circlePositionOnSlider(ratingPercentage: rating))
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Issue")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding([.leading, .top])
            CustomSliderBar(color: .black)
                .saveFrame(in: $sliderFrame)
                .overlay(
                    ZStack {
                        candidateCircle()
                        voterCircle()
                    }
                )
                .padding(.bottom)
        }
        .background(Theme.light_blue.mainColor)
    }
}

#Preview {
    PoliticalIssueSlider(candidateRatingPercentage: 0.5, voterRatingPercentage: 0.6)
}
