//
//  CustomBackButton+NoText.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct CustomBackButton_NoText: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left") // You can use any image here
                .aspectRatio(contentMode: .fit)
                .padding()
        }
    }
}

#Preview {
    CustomBackButton_NoText()
}
