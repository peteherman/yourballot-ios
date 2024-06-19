//
//  WelcomeView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var guestTrial = GuestTrial()
    @StateObject var voterAuthService: VoterAuthService
    @State var authSucceeded: Bool = false
    var body: some View {
        if self.authSucceeded {
            MainAuthenticatedView()
        } else {
            NavigationView {
                VStack {
                    Text("Your Ballot")
                        .font(.title)
                        .foregroundStyle(Theme.blue_accent.mainColor)
                        .padding()
                    NavigationButton_Rounded(destination: LoginView(provider: URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil), authSucceeded: $authSucceeded)) {
                        Text("Login")
                    }
                    NavigationButton_Rounded(destination: SignUpView(voterAuthService: voterAuthService, authSucceeded: $authSucceeded)) {
                        Text("Sign-Up")
                    }
                    NavigationLink(destination: GuestTrialZipView(authSucceeded: $authSucceeded)) {
                        Text("Try as Guest")
                    }
                }
            }        .toolbar(.hidden)
        }

    }
}

struct WelcomeView_Preview: PreviewProvider {
    static var voterAuthService = VoterAuthService(provider: MockVoterAuthProviderSuccess())
    static var previews: some View {
        WelcomeView(voterAuthService: voterAuthService)
    }
}
