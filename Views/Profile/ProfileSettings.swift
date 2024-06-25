//
//  ProfileSettings.swift
//  Your Ballot
//
//  Created by Peter Herman on 6/18/24.
//

import SwiftUI

struct ProfileSettings: View {
    public var profileService: ProfileService
    @State private var errorMessage: String = ""
    @State private var showEditEmailView: Bool = false
    @State private var showEditPasswordView: Bool = false
    @State private var showConfirmLogoutView: Bool = false

    
    var body: some View {
        VStack {
            HStack {
                Text("Edit Profile")
                    .font(.title2)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding([.top, .bottom], 20)
            StaticLabelAndField(label: "Email", field: profileService.voter?.email ?? "")
                .onTapGesture {
                    showEditEmailView = true
                }
            StaticLabelAndField(label: "Password", field: "**********")
                .onTapGesture {
                    showEditPasswordView = true
                }
            Button(action: {
                self.showConfirmLogoutView = true
            }) {
                Text("Logout")
            }
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .sheet(isPresented: $showEditEmailView) {
            Text("Edit Email")
        }
        .sheet(isPresented: $showEditPasswordView) {
            Text("Edit Password")
        }
        .sheet(isPresented: $showConfirmLogoutView) {
            ConfirmLogoutView(voterAuthService: VoterAuthService(provider: insecure_provider()))
        }
    }
}

struct StaticLabelAndField: View {
    public var label: String
    public var field: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(label)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Theme.deep_blue.mainColor)
                .font(.title3)
            HStack {
                Text("\(field)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "pencil.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .padding([.top, .bottom], 10.0)
            .padding([.leading, .trailing], 5.0)
            .background(Theme.light_blue.mainColor)
            .cornerRadius(5.0)
        }
    }
}

struct ConfirmLogoutView: View {
    public var voterAuthService: VoterAuthService
    var body: some View {
        Button(action: {
            voterAuthService.clearTokens()
        }) {
            Text("Logout")
        }
    }
}

#Preview {
    ProfileSettings(profileService: ProfileService(provider: insecure_provider()))
}
