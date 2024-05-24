//
//  VoterAuthService.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/24/24.
//

import Foundation

class VoterAuthService {
    private let provider: any HTTPProvider
    private let decoder: JSONDecoder = JSONDecoder()
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
    func login(email: String, password: String) async throws {
        
    }
    
}
