//
//  PoliticalParty.swift
//  Your Ballot
//
//  Created by Peter Herman on 3/29/24.
//

import Foundation

enum PoliticalParty: String, Decodable, CaseIterable {
    case choose_not_to_share
    case democratic
    case republican
    case independent
    case libertarian
    case forward
    case vermont_progressive
    case independent_of_oregon
    case green
    case constitution
    case working_families
    case alliance
    case reform
    case working_class
    case socialism_liberation
    case american_independent
    case peace_freedom
    case solidarity
    case legal_marijuana
    case unity_party
    case natural_law
    case approval_voting
    case justice
    case people
    case colorado_center
    case conservative_ny
    case libertarian_mass
    case libertariran_nm
    case oregon_progressive
    case green_mountain
    case alaskan_independence
    case independent_delaware
    case united_utah
    case ecology_florida
    case independent_florida
    case aloha
    case grassroots_cannabis
    case labor
    case united_citizens
    case independent_citizens
    case sovereign_union
    case socialist_workers
    case prohibition
    case socialist_equality
    case socialist_usa
    case communist
    case progressive_labor
    case socialist_alternative
    case pirate
    case workers_world
    case freedom_socialist
    case american_freedom
    case socialist_action
    case transhumanist
}

extension PoliticalParty {
    func string() -> String {
        switch self {
        case .democratic:
            return "Democratic"
        case .republican:
            return "Republican"
        case .independent:
            return "Independent"
        case .libertarian:
            return "Libertarian"
        case .forward:
            return "Forward"
        case .vermont_progressive:
            return "Vermont Progressive"
        case .independent_of_oregon:
            return "Independent Of Oregon"
        case .green:
            return "Green"
        case .constitution:
            return "Constitution"
        case .working_families:
            return "Working Families"
        case .alliance:
            return "Alliance"
        case .reform:
            return "Reform"
        case .working_class:
            return "Working Class"
        case .socialism_liberation:
            return "Socialism Liberation"
        case .american_independent:
            return "American Independent"
        case .peace_freedom:
            return "Peace Freedom"
        case .solidarity:
            return "Solidarity"
        case .legal_marijuana:
            return "Legal Marijuana"
        case .unity_party:
            return "Unity Party"
        case .natural_law:
            return "Natural Law"
        case .approval_voting:
            return "Approval Voting"
        case .justice:
            return "Justice"
        case .people:
            return "People"
        case .colorado_center:
            return "Colorado Center"
        case .conservative_ny:
            return "Conservative Ny"
        case .libertarian_mass:
            return "Libertarian Mass"
        case .libertariran_nm:
            return "Libertariran Nm"
        case .oregon_progressive:
            return "Oregon Progressive"
        case .green_mountain:
            return "Green Mountain"
        case .alaskan_independence:
            return "Alaskan Independence"
        case .independent_delaware:
            return "Independent Delaware"
        case .united_utah:
            return "United Utah"
        case .ecology_florida:
            return "Ecology Florida"
        case .independent_florida:
            return "Independent Florida"
        case .aloha:
            return "Aloha"
        case .grassroots_cannabis:
            return "Grassroots Cannabis"
        case .labor:
            return "Labor"
        case .united_citizens:
            return "United Citizens"
        case .independent_citizens:
            return "Independent Citizens"
        case .sovereign_union:
            return "Sovereign Union"
        case .socialist_workers:
            return "Socialist Workers"
        case .prohibition:
            return "Prohibition"
        case .socialist_equality:
            return "Socialist Equality"
        case .socialist_usa:
            return "Socialist Usa"
        case .communist:
            return "Communist"
        case .progressive_labor:
            return "Progressive Labor"
        case .socialist_alternative:
            return "Socialist Alternative"
        case .pirate:
            return "Pirate"
        case .workers_world:
            return "Workers World"
        case .freedom_socialist:
            return "Freedom Socialist"
        case .american_freedom:
            return "American Freedom"
        case .socialist_action:
            return "Socialist Action"
        case .transhumanist:
            return "Transhumanist"
        case .choose_not_to_share:
            return "Choose not to share"
        }

    }
}
