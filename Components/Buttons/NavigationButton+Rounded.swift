//
//  NavigationButton+Rounded.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/17/24.
//

import SwiftUI

struct NavigationButton_Rounded<Content: View, Destination: View>: View {
    let destination: Destination
    let content: () -> Content
    
    init(destination: Destination, @ViewBuilder content: @escaping () -> Content) {
        self.destination = destination
        self.content = content
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: destination) {
                content()
            }
        }
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .padding()
        .cornerRadius(10.0)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Theme.light_blue_accent.mainColor, lineWidth: 2)
        )
    }
}

#Preview {
    NavigationButton_Rounded(destination: WelcomeView(), content: {})
}
