//
//  WelcomeView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Ballot")
                    .font(.title)
                    .foregroundStyle(Theme.blue_accent.mainColor)
                    .padding()
                NavigationButton_Rounded(destination: LoginView()) {
                    Text("Login")
                }
                NavigationButton_Rounded(destination: LoginView()) {
                    Text("Sign-Up")
                }
                NavigationLink(destination: GuestTrialZipView()) {
                    Text("Try as Guest")
                }
            }
        }
    }
}

struct WelcomeView_Preview: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
