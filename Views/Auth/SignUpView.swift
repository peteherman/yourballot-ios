//
//  SignUpView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm_password: String = ""
    @State private var errorMessage: String = ""
    @State private var birthDate: Date = Date()
    @State private var ethnicity: Ethnicity = .choose_not_to_share
    @State private var races: Set<Race> = [.choose_not_to_share]
    @State private var gender: Gender = .choose_not_to_share
    @State private var political_party: PoliticalParty  = .choose_not_to_share
    @State private var zipcode: String = ""
    @State private var political_identity: String = ""
    @State private var loading: Bool = false
    @Binding var authSucceeded: Bool
    private var answeredQuestions: [IssueQuestion] = []
    private var provider: any HTTPProvider = URLSession(configuration: .default)
    public var voterAuthService: VoterAuthService
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    
    func validEmail() -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validPassword() -> Bool {
        return password.count > 6 // && password == confirm_password
    }
    
    func validZip() -> Bool {
        return zipcode.count == 5
    }
    
    func validForm() -> Bool {
        return self.validEmail() && self.validPassword() && self.validZip()
    }
    
    func limitTextLength(_ length: Int) {
        if zipcode.count > length {
            zipcode = String(zipcode.prefix(length))
        }
    }
    
    init(zipcode: String = "", answeredQuestions: [IssueQuestion] = [], voterAuthService: VoterAuthService? = nil, authSucceeded: Binding<Bool>) {
        _zipcode = State(initialValue: zipcode)
        self.answeredQuestions = answeredQuestions
        if voterAuthService != nil {
            self.voterAuthService = voterAuthService!
        } else {
            self.voterAuthService = VoterAuthService(provider: insecure_provider())
        }
        
        self._authSucceeded = authSucceeded
    }
    
    func makeRegisterRequest() async -> Void {
        // TODO: Cleanup this guy, not grabbing everything, multiple races, etc
        let voterRegistrationBody = VoterRegistrationRequestBody(email: email, password: password, zipcode: zipcode, political_identity: political_identity, age: nil, ethnicity: ethnicity, gender: gender, race: races.first, political_party: political_party)
        
        self.loading = true
        self.errorMessage = ""
        
        do {
            let (authTokens, apiErrorMessage) = try await self.voterAuthService.register(registerBody: voterRegistrationBody)
            self.loading = false
            if authTokens != nil {
                await MainActor.run {
                    self.authSucceeded = true
                }
            } else {
                await MainActor.run {
                    self.authSucceeded = false
                    self.errorMessage = apiErrorMessage
                }
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "An unknown error occurred. Please try again later"
                self.loading = false
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Register")
                    .font(.title)
                    .foregroundStyle(Theme.deep_blue.mainColor)
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
                        .frame(height: 25)
                }
                LabelAndField(label: "Email*") {
                    TextField("Email", text: $email)
                }
                LabelAndField(label: "Password*") {
                    SecureField("Password", text: $password)
                }
                LabelAndField(label: "Zipcode*") {
                    TextField("Zipcode", text: $zipcode)
                        .onReceive(Just(zipcode), perform: { _ in
                            limitTextLength(5)
                        })
                }
                LabelAndField(label: "Birth Date") {
                    DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                }
                LabelAndField(label: "Ethnicity") {
                    Picker("Select Ethnicity", selection: $ethnicity) {
                        ForEach(Ethnicity.allCases, id: \.self) { picker_ethnicity in
                            Text(picker_ethnicity.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                LabelAndField(label: "Race") {
                    ForEach(Race.allCases, id: \.self) { race in
                        Toggle(race.rawValue, isOn: Binding<Bool>(
                            get: { self.races.contains(race) },
                            set: { if $0 { self.races.insert(race) } else { self.races.remove(race) } }
                        ))
                    }
                }
                LabelAndField(label: "Gender") {
                    Picker("Select Gender", selection: $gender) {
                        ForEach(Gender.allCases, id: \.self) { picker_gender in
                            Text(picker_gender.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                LabelAndField(label: "Political Affiliation") {
                    Picker("Select Political Affiliation", selection: $political_party) {
                        ForEach(PoliticalParty.allCases, id: \.self) { picker_party in
                            Text(picker_party.string())
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                LabelAndField(label: "Political Identity") {
                    TextField("How would you describe yourself, politically", text: $political_identity)
                }
            }
            .padding([.leading, .trailing], 15.0)
            Spacer()
                .frame(height: 50)
            if (self.validForm()) {
                Button(action: {
                    Task {
                        await makeRegisterRequest()
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
            } else {
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
        }
        .toolbarRole(.editor)
    }
}

struct SignUpView_Preview: PreviewProvider {
    static var provider = MockVoterAuthProviderSuccess()
    static var voterAuthService = VoterAuthService(provider: provider)
    static var previews: some View {
        @State var authSuceeded: Bool = false
        SignUpView(voterAuthService: voterAuthService, authSucceeded: $authSuceeded)
    }
}
