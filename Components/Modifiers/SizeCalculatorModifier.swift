//
//  SizeCalculatorModifier.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/3/24.
//

import SwiftUI

struct SizeCalculatorModifier: ViewModifier {
    @Binding var frame: CGRect
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear // want reader to get triggered, so we'll use an empty color
                        .onAppear {
                            self.frame = proxy.frame(in: .local)
                        }
                }
            )
    }
}

extension View {
    func saveFrame(in frame: Binding<CGRect>) -> some View {
        modifier(SizeCalculatorModifier(frame: frame))
    }
}
