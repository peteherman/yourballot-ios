//
//  TestCandidateData.swift
//  Your BallotTests
//
//  Created by Peter Herman on 4/9/24.
//

import Foundation

let testCandidateDetail = """
{
    "result_info": {
        "next": null,
        "previous": null,
        "total": 0
    },
    "result": {
        "id": 1,
        "external_id": "b275f458-1f71-401b-b77c-1da58331cd69",
        "name": "Joe Biden",
        "age": 81,
        "bio": "Together, we can finish the job for the American People",
        "start_date": "2020-01-20T12:00:00Z",
        "similarity": 0.6509835247441749,
        "ethnicity": "not_hispanic_or_latino",
        "gender": "MALE",
        "political_identity": "Democrat",
        "political_party": "democratic",
        "position": {
            "id": 1,
            "title": "President",
            "locality": {
                "id": 58,
                "geo_json_id": "3a70ac55-0623-4cfb-806a-a34a3b71b1b3",
                "created": "2024-04-05T11:27:30.893103Z",
                "updated": "2024-04-05T11:27:30.893132Z",
                "name": "United States",
                "type": "federal"
            },
            "term_limit": 1460
        },
        "url": "https://joebiden.com",
        "profile_photo": null,
        "issue_views": {
            "Healthcare": 8.75,
            "Abortion": -9.25,
            "Gun Control": -5.0,
            "Environment": 8.0,
            "Immigration": -6.0
        },
        "twitter": null,
        "facebook": null
    }
}
""".data(using: .utf8)!
