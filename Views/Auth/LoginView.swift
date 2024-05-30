//
//  LoginView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var loading: Bool = false
    @State private var authSucceeded: Bool = false
    private var provider: any HTTPProvider = URLSession(configuration: .default)
    public var voterAuthService: VoterAuthService
    
    init(email: String = "", password: String = "", errorMessage: String = "", loading: Bool = false, authSucceeded: Bool = false, provider: any HTTPProvider = URLSession(configuration: .default), voterAuthService: VoterAuthService? = nil) {
        self.email = email
        self.password = password
        self.errorMessage = errorMessage
        self.loading = loading
        self.authSucceeded = authSucceeded
        self.provider = provider
        if voterAuthService == nil {
            self.voterAuthService = VoterAuthService(provider: self.provider)
        } else {
            self.voterAuthService = voterAuthService!
        }
    }
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    func validForm() -> Bool {
        return self.validEmail() && self.validPassword()
    }
    
    func validEmail() -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validPassword() -> Bool {
        return password.count > 6
    }
    
    func makeLoginRequest() async -> Void {
        self.loading = true
        self.errorMessage = ""
        do {
            let (authTokens, apiErrorMessage) = try await self.voterAuthService.login(email: email, password: password)
            self.loading = false
            if authTokens != nil {
                self.authSucceeded = true
            } else {
                self.errorMessage = apiErrorMessage
                self.authSucceeded = false
            }
        } catch {
            errorMessage = "An unknown error occurred. Please try again later"
            self.loading = false
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Login")
                        .font(.title)
                        .foregroundStyle(Theme.deep_blue.mainColor)
                    errorMessageView
                    LabelAndField(label: "Email") {
                        TextField("Email", text: $email)
                    }
                    LabelAndField(label: "Password") {
                        SecureField("Password", text: $password)
                    }
                }
                .padding([.leading, .trailing], 15.0)
                Spacer().frame(height: 50)
                buttonOrSpinner
            }
            .toolbarRole(.editor)
            
            // NavigationLink to navigate to HomeVoterCandidatesView
            NavigationLink(
                destination: HomeVoterCandidatesView(candidateService: VoterCandidatesService(provider: self.provider)),
                isActive: $authSucceeded,
                label: {
                    EmptyView()
                })
        }
    }
    
    var errorMessageView: some View {
        VStack {
            if errorMessage == "" {
                Spacer()
                    .frame(height: 50)
            } else {
                Spacer()
                    .frame(height: 25)
                Text("\(errorMessage)")
                    .font(.title3)
                    .foregroundStyle(Theme.deep_red.mainColor)
                Spacer()
                    .frame(height: 10)
            }
        }
    }
    
    var buttonOrSpinner: some View {
        VStack {
            if self.validForm() {
                if self.loading {
                    loadingSpinner
                } else {
                    submitButton
                }
            } else {
                disabledSubmitButton
            }
        }
    }
    
    var disabledSubmitButton: some View {
        Button(action: {}, label: {
            Text("Submit")
                .font(.headline)
                .foregroundColor(.black)
                .padding([.leading, .trailing])
        })
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .padding()
        .background(Theme.light_gray.mainColor)
        .cornerRadius(10.0)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(.gray, lineWidth: 2)
        )
        .padding(.bottom)
        .disabled(true)
    }
    
    var submitButton: some View {
        Button(action: {
            Task {
                await makeLoginRequest()
            }
        }, label: {
            Text("Submit")
                .font(.headline)
                .foregroundColor(.black)
                .padding([.leading, .trailing])
        })
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .padding()
        .background(Theme.light_blue.mainColor)
        .cornerRadius(10.0)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Theme.light_blue_accent.mainColor, lineWidth: 2)
        )
        .padding(.bottom)
    }
    
    var loadingSpinner: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(2)  // Optional: scale to make it larger
            .padding()
    }
}

struct LoginView_Preview: PreviewProvider {
    static var provider = MockVoterAuthProviderSuccess()
    static var voterAuthService = VoterAuthService(provider: provider)
    static var previews: some View {
        LoginView(voterAuthService: voterAuthService)
    }
}
