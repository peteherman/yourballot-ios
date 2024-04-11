//
//  ColoredSlider.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct PoliticalIssueSlider: View {
    @State private var sliderFrame: CGRect = .zero
    let issueName: String
    let candidateRating: Double
    let voterRating: Double
    
    func circlePositionOnSlider(rating: Double) -> CGPoint {
        let midpoint = sliderFrame.midX
        let xPosition = midpoint + ((rating / 22) * sliderFrame.width)
        return CGPoint(x: xPosition, y: sliderFrame.midY)
    }
    
    func candidateCircle() -> some View {
        return sliderCircle(color: .blue, rating: candidateRating)
    }
    
    func voterCircle() -> some View {
        return sliderCircle(color: .white, rating: voterRating)
    }
    
    func sliderCircle(color: Color, rating: Double) -> some View {
        return Circle()
            .fill(color)
            .frame(width: 30)
            .position(circlePositionOnSlider(rating: rating))
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(issueName)
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
    PoliticalIssueSlider(issueName: "Issue Name", candidateRating: 10, voterRating: -7.5)
}
