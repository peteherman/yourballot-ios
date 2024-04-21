//
//  LabelAndField.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/21/24.
//

import SwiftUI

struct LabelAndField<Content: View>: View {
    let label: String
    let field: () -> Content
    var body: some View {
        VStack(spacing: 10) {
            Text("\(label)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Theme.deep_blue.mainColor)
                .font(.title3)
            VStack {
                field()
            }
            .padding([.top, .bottom], 10.0)
            .padding([.leading, .trailing], 5.0)
            .background(Theme.light_blue.mainColor)
            .cornerRadius(5.0)
        }
    }
}

#Preview {
    LabelAndField(label: "Email") {
        TextField("Email", text: .constant("test@mail.com"))
    }
}
