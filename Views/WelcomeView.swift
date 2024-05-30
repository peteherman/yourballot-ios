//
//  WelcomeView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var guestTrial = GuestTrial()
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Ballot")
                    .font(.title)
                    .foregroundStyle(Theme.blue_accent.mainColor)
                    .padding()
                NavigationButton_Rounded(destination: LoginView(provider: URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil))) {
                    Text("Login")
                }
                NavigationButton_Rounded(destination: SignUpView()) {
                    Text("Sign-Up")
                }
                NavigationLink(destination: GuestTrialZipView()) {
                    Text("Try as Guest")
                }
            }
        }
        .toolbar(.hidden)
    }
}

struct WelcomeView_Preview: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
