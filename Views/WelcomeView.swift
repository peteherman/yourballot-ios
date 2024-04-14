//
//  WelcomeView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var guestTrial: GuestTrial
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Ballot")
                    .font(.title)
                    .foregroundStyle(Theme.blue_accent.mainColor)
                    .padding()
                VStack {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .foregroundStyle(Theme.deep_blue.mainColor)
                    }
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Theme.light_blue.mainColor)
                .cornerRadius(10.0)
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Theme.light_blue_accent.mainColor, lineWidth: 2)
                )
                VStack {
                    NavigationLink(destination: LoginView()) {
                        Text("Sign-Up")
                            .foregroundStyle(Theme.deep_blue.mainColor)
                    }
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Theme.light_blue.mainColor)
                .cornerRadius(10.0)
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Theme.light_blue_accent.mainColor, lineWidth: 2)
                )
                NavigationLink(destination: GuestTrialZipView(guestTrial: guestTrial)) {
                    Text("Try as Guest")
                }
            }
        }
    }
}

struct WelcomeView_Preview: PreviewProvider {
    static var previews: some View {
        WelcomeView(guestTrial: GuestTrial())
    }
}
