//
//  LoginView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        Text("Login View")
        NavigationLink(destination: MainAuthenticatedView()) {
            Text("Go Home")
        }
    }
}

#Preview {
    LoginView()
}
