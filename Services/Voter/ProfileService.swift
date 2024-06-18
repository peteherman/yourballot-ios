//
//  ProfileService.swift
//  Your Ballot
//
//  Created by Peter Herman on 6/18/24.
//

import Foundation

class ProfileService: BaseService, ObservableObject {
    
    private let provider: any HTTPProvider
    
    init(provider: any HTTPProvider = URLSession.shared) {
        self.provider = provider
    }
    
}

