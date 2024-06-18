//
//  Your_BallotApp.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/17/24.
//

import SwiftUI
import OSLog

@main
struct Your_BallotApp: App {
    @StateObject private var questionService = QuestionService(provider: MockQuestionProvider())
    @StateObject private var voterAuthService = VoterAuthService(provider: URLSession(configuration: .default, delegate: CustomSessionDelegate(), delegateQueue: nil))
    @State private var isAuth: Bool = false
    private var logger: Logger = Logger()
    
    var body: some Scene {
        WindowGroup {
            if self.isAuth {
                //HomeVoterCandidatesView(candidateService: VoterCandidatesService(provider: insecure_provider()), voterAuthService: voterAuthService)
                MainAuthenticatedView()
            } else {
                WelcomeView(voterAuthService: voterAuthService)
                    .task {
                        do {
                            logger.info("Attempting to refresh auth tokens on app startup")
                            self.isAuth = try await voterAuthService.isAuthenticatedTryTokens()
                            logger.info("Refresh token attempt on startup: \(self.isAuth)")
                        } catch {
                            logger.warning("Attempt to refresh auth tokens on app startup failed: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
}
