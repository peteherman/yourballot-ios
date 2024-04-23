//
//  VoterIssueSlider.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI

struct VoterIssueSlider: View {
    @State private var sliderFrame: CGRect = .zero
    let issueName: String
    let voterRating: Double
    
    func circlePositionOnSlider(rating: Double) -> CGPoint {
        let midpoint = sliderFrame.midX
        let xPosition = midpoint + ((rating / 22) * sliderFrame.width)
        return CGPoint(x: xPosition, y: sliderFrame.midY)
    }
    
    func voterCircle() -> some View {
        let circleColor = harshColorFromValue(voterRating)
        return sliderCircle(color: circleColor, rating: voterRating)
    }
    
    func sliderCircle(color: Color, rating: Double) -> some View {
        let circlePosition = circlePositionOnSlider(rating: rating)
        return Circle()
            .fill(color)
            .frame(width: 30)
            .position(circlePosition)
            .overlay {
                Circle()
                    .stroke(.black, lineWidth: 2)
                    .frame(width: 32)
                    .position(circlePosition)
            }
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(issueName)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding([.leading, .top])
            CustomSliderBar(color: Theme.light_gray.mainColor)
                .saveFrame(in: $sliderFrame)
                .overlay(
                    ZStack {
                        voterCircle()
                    }
                )
                .padding(.bottom)
        }
        .background(lightColorFromValue(voterRating))
    }
}

#Preview {
    VoterIssueSlider(issueName: "Healthcare", voterRating: -1.0)
}
