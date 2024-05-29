//
//  GuestTrialZipView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI
import Combine

struct GuestTrialZipView: View {
    @State private var isVisible = true
    @State private var animationAmount = 1.0
    @FocusState private var isZipEntryFocused: Bool
    @State private var zipcode: String = ""
    
    func limitTextLength(_ length: Int) {
        if zipcode.count > length {
            zipcode = String(zipcode.prefix(length))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(maxHeight: 200)
            Text("Please enter your zipcode")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding([.bottom], 5)
            Text("We'll need this so we can \nidentify your representatives")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding([.bottom])
            TextField("Zipcode", text: $zipcode)
                .onReceive(Just(zipcode), perform: { _ in
                    limitTextLength(5)
                })
                .keyboardType(.numberPad)
                .focused($isZipEntryFocused)
                .padding()
            VStack {
                NavigationLink(destination: GuestQuestionView(questionService: GuestQuestionService(provider: insecure_provider()), zipcode: zipcode)
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
            isZipEntryFocused = true
        }
        .toolbarRole(.editor)
    }
}

#Preview {
    GuestTrialZipView()
}
