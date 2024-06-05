//
//  GuestMatchesView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/14/24.
//

import SwiftUI

struct GuestMatchesView: View {
    @ObservedObject var guestQuestionService: GuestQuestionService
    let zipcode: String
    let answeredQuestions: [IssueQuestion]
    
    @ViewBuilder
    var body: some View {
        if guestQuestionService.candidateMatches.count > 0 {
            GuestMatchesView_CandidateList(guestQuestionService: guestQuestionService, zipcode: zipcode, answeredQuestions: answeredQuestions)
        } else {
            GuestMatchesView_LoadingCandidates(guestQuestionService: guestQuestionService, zipcode: zipcode, answeredQuestions: answeredQuestions)
        }
    }
}

struct GuestMatchesView_LoadingCandidates: View {
    @ObservedObject var guestQuestionService: GuestQuestionService
    let zipcode: String
    let answeredQuestions: [IssueQuestion]
    
    var body: some View {
        // Still need to fetch questions
        Text("Finding Candidates")
            .onAppear {
                Task {
                    do {
                        try await guestQuestionService.fetchMatches(zipcode: zipcode, answeredQuestions: answeredQuestions)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .toolbar(.hidden)
    }
}

struct GuestMatchesView_CandidateList: View {
    @ObservedObject var guestQuestionService: GuestQuestionService
    let zipcode: String
    let answeredQuestions: [IssueQuestion]
    var body: some View {
        let candidateLocalityMap = guestQuestionService.groupCandidatesByLocalityType()
        VStack {
            ScrollView {
                Text("Your Matches")
                    .font(.title2)
                    .foregroundStyle(Theme.deep_blue.mainColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading], 20)
                    .padding([.bottom])
                ForEach(Array(candidateLocalityMap.keys), id: \.self) { localityType in
                    VStack(spacing: 5) {
                        Text("\(localityType.pretty)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, ], 20)
                        CandidateListComponent(candidates: candidateLocalityMap[localityType]!)
                    }
                }
            }
            HStack {
                NavigationLink(destination: SignUpView(zipcode: zipcode, answeredQuestions: answeredQuestions)) {
                    RoundedRectangle_Blue(buttonText: "Sign-Up")
                }
                
                NavigationLink(destination: WelcomeView(voterAuthService: VoterAuthService(provider: URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil)))) {
                    RoundedRectangle_Red(buttonText: "Restart")
                }
                .isDetailLink(false)
            }
        }
        .toolbar(.hidden)
    }
}

struct GuestMatches_Preview: PreviewProvider {
    static var mockGuestQuestionProvider = MockGuestQuestionProvider()
    static var guestQuestionService = GuestQuestionService(provider: mockGuestQuestionProvider, candidateMatches: Candidate.sampleData)
    static var guestTrial = GuestTrial()
    static var previews: some View {
        GuestMatchesView(guestQuestionService: guestQuestionService, zipcode: "12831", answeredQuestions: [])
    }
}
