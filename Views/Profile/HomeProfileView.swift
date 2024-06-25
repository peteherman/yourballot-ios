//
//  HomeProfileView.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/22/24.
//

import SwiftUI

struct HomeProfileView: View {
    public var profileService: ProfileService
    @State private var loading: Bool = true
    @State private var errorMessage: String = ""
    
    
    init(profileService: ProfileService? = nil) {
        let provider = insecure_provider()
        if profileService == nil {
            self.profileService = ProfileService(provider: provider)
        } else {
            self.profileService = profileService!
        }
    }
    
    func fetchProfile() async -> Void {
        do {
            try await profileService.fetchProfile()
            await MainActor.run {
                self.loading = false
            }
        } catch {
            print("Caught error: \(error.localizedDescription)")
            await MainActor.run {
                self.errorMessage = "An unknown error occurred. Please try again later"
                self.loading = false
            }
        }
        
    }
    
    var body: some View {
        if loading {
            loadingSpinner
                .task {
                    await fetchProfile()
                }
        } else if !loading && profileService.voter != nil {
            profileView
        } else {
            VStack {
                Text("\(errorMessage)")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    var loadingSpinner: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(2)  // Optional: scale to make it larger
            .padding()
    }    
    
    var profileView: some View {
        ScrollView {
            VStack {
                NavigationLink(destination: ProfileSettings(profileService: profileService)) {
                    HStack {
                        Text("Profile")
                            .font(.title2)
                        Image(systemName: "gearshape")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom], 10)
                }
                Text("Political Profile")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom], 5)
                PoliticalProfileHeaderView(voter: profileService.voter!)
                    .padding([.bottom], 20)
                HStack {
                    Text("Issues")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Prior Responses")
                }
                .padding([.bottom], 10)
                NavigationLink(destination: IssueRankingView()) {
                    Text("Change what matters most to you")
                }
                if (profileService.voter!.issue_views == nil) {
                    Text("Answer some questions so you can view your Political Profile!")
                        .multilineTextAlignment(.center)
                        .padding([.top], 30)
                } else {
                    let issue_views = profileService.voter!.issue_views ?? [:]
                    VStack {
                        ForEach(Array(issue_views.keys), id: \.self) {
                            issue_name in
                            let voterRating = issue_views[issue_name] ?? 0.0
                            VoterIssueSlider(issueName: issue_name, voterRating: voterRating)
                                .cornerRadius(7.0)
                                .padding([.leading, .trailing])
                        }
                    }
                    .padding([.bottom])
                }
            }
            .padding([.leading, .trailing], 20)

        }
    }
}

#Preview {
    HomeProfileView(profileService: ProfileService(provider: insecure_provider()))
}
