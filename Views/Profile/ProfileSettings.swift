//
//  ProfileSettings.swift
//  Your Ballot
//
//  Created by Peter Herman on 6/18/24.
//

import SwiftUI

struct ProfileSettings: View {
    private var profileService: ProfileService
    @State private var errorMessage: String = ""
    @State private var showEditEmailView: Bool = false
    @State private var showEditPasswordView: Bool = false

    init(profileService: ProfileService? = nil) {
        let provider = insecure_provider()
        if profileService == nil {
            self.profileService = ProfileService(provider: provider)
        } else {
            self.profileService = profileService!
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Edit Profile")
                    .font(.title2)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding([.top, .bottom], 20)
            StaticLabelAndField(label: "Email", field: "test@mail.com")
                .onTapGesture {
                    showEditEmailView = true
                }
            StaticLabelAndField(label: "Password", field: "**********")
                .onTapGesture {
                    showEditPasswordView = true
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

#Preview {
    ProfileSettings()
}
