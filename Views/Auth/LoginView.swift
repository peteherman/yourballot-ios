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
    
    
    var body: some View {
        VStack {
            Text("Login")
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
            }
            LabelAndField(label: "Email") {
                TextField("Email", text: $email)
            }
            LabelAndField(label: "Password") {
                SecureField("Password", text: $password)
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
}

#Preview {
    LoginView()
}
