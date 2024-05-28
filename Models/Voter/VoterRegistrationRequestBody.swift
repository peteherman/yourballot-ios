//
//  VoterRegistrationRequestBody.swift
//  Your Ballot
//
//  Created by Peter Herman on 5/28/24.
//

import Foundation

struct VoterRegistrationRequestBody: Encodable {
    let email: String
    let password: String
    let zipcode: String
    let political_identity: String
    let age: Int?
    let ethnicity: Ethnicity?
    let gender: Gender?
    let race: Race?
    let political_party: PoliticalParty?
    
    init(email: String, password: String, zipcode: String, political_identity: String = "", age: Int? = nil, ethnicity: Ethnicity? = nil, gender: Gender? = nil, race: Race? = nil, political_party: PoliticalParty? = nil) {
        self.email = email
        self.password = password
        self.zipcode = zipcode
        self.political_identity = political_identity
        self.age = age
        self.ethnicity = ethnicity
        self.gender = gender
        self.race = race
        self.political_party = political_party
    }
}
