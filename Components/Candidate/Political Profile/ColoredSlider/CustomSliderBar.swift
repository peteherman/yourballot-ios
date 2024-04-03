//
//  CustomSliderBar.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct CustomSliderBar: View {
    let color: Color
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .frame(width: 5, height: 20)
                .foregroundStyle(color)
            Rectangle()
                .frame(height: 7)
                .foregroundStyle(color)
            Rectangle()
                .frame(width: 5, height: 20)
                .foregroundStyle(color)
        }
        .padding()
    }
}

#Preview {
    CustomSliderBar(color: .black)
}
