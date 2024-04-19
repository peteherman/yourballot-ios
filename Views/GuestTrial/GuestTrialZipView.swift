//
//  GuestTrialZipView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct GuestTrialZipView: View {
    @State private var isVisible = true
    @State private var animationAmount = 1.0
    @FocusState private var isZipEntryFocused: Bool
    @State private var zipcode: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(maxHeight: 200)
                Text("Please enter your zipcode")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding([.bottom], 5)
                Text("We'll need this so we can \nidentify your representatives")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding([.bottom])
                TextField("Zipcode", text: $zipcode)
                    .keyboardType(.numberPad)
                    .focused($isZipEntryFocused)
                    .padding()
                VStack {
                    NavigationLink(destination: GuestQuestionView(questionService: GuestQuestionService(provider: MockQuestionProvider()))
                    ) {
                        Text("Continue")
                            .foregroundStyle(Theme.deep_blue.mainColor)
                    }
                    .disabled(zipcode.count != 5)
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Theme.light_blue.mainColor)
                .cornerRadius(10.0)
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Theme.light_blue_accent.mainColor, lineWidth: 2)
                )
                Spacer()
            }
            .animation(.easeInOut(duration: 1), value: animationAmount)
            .padding()
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                isVisible = true
            }

        }
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationBarItems(leading: CustomBackButton_NoText())
        .onAppear {
            isZipEntryFocused = true
        }
    }
}

#Preview {
    GuestTrialZipView()
}
