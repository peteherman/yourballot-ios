//
//  GuestMatchesView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct GuestMatchesView: View {
    let guestQuestionService: GuestQuestionService
    let guestTrial: GuestTrial
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GuestMatches_Preview: PreviewProvider {
    static var mockGuestQuestionProvider = MockGuestQuestionProvider()
    static var guestQuestionService = GuestQuestionService(provider: mockGuestQuestionProvider)
    static var guestTrial = GuestTrial()
    
    static var previews: some View {
        GuestMatchesView(guestQuestionService: guestQuestionService, guestTrial: guestTrial)
    }
}
