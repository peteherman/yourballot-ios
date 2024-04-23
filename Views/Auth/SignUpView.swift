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
    @State private var birthDate: Date = Date()
    @State private var ethnicity: Ethnicity = .choose_not_to_share
    @State private var races: Set<Ethnicity> = [.choose_not_to_share]
    @State private var gender: Gender = .choose_not_to_share
    @State private var political_party: PoliticalParty  = .choose_not_to_share
    @State private var zipcode: String = ""
    @State private var political_identity: String = ""
    private var answeredQuestions: [IssueQuestion] = []
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
    
    init(zipcode: String = "", answeredQuestions: [IssueQuestion] = []) {
        _zipcode = State(initialValue: zipcode)
        self.answeredQuestions = answeredQuestions
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Register")
                    .font(.title)
                    .foregroundStyle(Theme.deep_blue.mainColor)
                    .padding([.bottom])
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
                    ForEach(Ethnicity.allCases, id: \.self) { ethnicity in
                        Toggle(ethnicity.rawValue, isOn: Binding<Bool>(
                            get: { self.races.contains(ethnicity) },
                            set: { if $0 { self.races.insert(ethnicity) } else { self.races.remove(ethnicity) } }
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
                Button(action: {}, label: {
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

#Preview {
    SignUpView()
}
