//
//  TestVoterCandidatesData.swift
//  Your Ballot
//
//  Created by Peter Herman on 4/12/24.
//

import Foundation

let testVoterCandidatesData = """
{
    "result_info": {
        "next": null,
        "previous": null,
        "total": 2
    },
    "result": [
        {
            "id": 2,
            "external_id": "d949ed76-9c69-4082-8634-eaa06ec82795",
            "name": "April Johnson",
            "age": 18,
            "bio": "Nor kind reflect.",
            "start_date": "2023-11-25T19:32:10Z",
            "similarity": 0.9329179606750063,
            "ethnicity": "Not Hispanic or Latino",
            "gender": "female",
            "political_identity": "Joshua Harris",
            "political_party": "republican",
            "position": {
                "id": 2,
                "title": "David Martinez",
                "locality": {
                    "id": 59,
                    "geo_json_id": null,
                    "created": "2024-04-12T11:11:16.760726Z",
                    "updated": "2024-04-12T11:50:32.246826Z",
                    "name": "test",
                    "type": "TOWN"
                },
                "term_limit": 625
            },
            "url": "http://lopez.com/",
            "profile_photo": "https://www.alvarado.com/",
            "issue_views": {
                "Healthcare": 0.0,
                "Abortion": 0.0,
                "Gun Control": 0.0,
                "Environment": 0.0,
                "Immigration": 0.0
            },
            "twitter": "http://www.smith-kelly.com/",
            "facebook": "https://rush.net/"
        },
        {
            "id": 3,
            "external_id": "cec5fefd-1019-48d2-829c-a71c02672fad",
            "name": "Erin Lin",
            "age": 27,
            "bio": "Manager number economy carry term us.",
            "start_date": "2021-04-20T22:05:54Z",
            "similarity": 0.9329179606750063,
            "ethnicity": "Hispanic or Latino",
            "gender": "male",
            "political_identity": "David Daniel",
            "political_party": "democratic",
            "position": {
                "id": 3,
                "title": "Lisa Mccoy",
                "locality": {
                    "id": 59,
                    "geo_json_id": null,
                    "created": "2024-04-12T11:11:16.760726Z",
                    "updated": "2024-04-12T11:50:32.246826Z",
                    "name": "test",
                    "type": "TOWN"
                },
                "term_limit": 470
            },
            "url": "https://bell.info/",
            "profile_photo": "https://burke.org/",
            "issue_views": {
                "Healthcare": 0.0,
                "Abortion": 0.0,
                "Gun Control": 0.0,
                "Environment": 0.0,
                "Immigration": 0.0
            },
            "twitter": "https://www.jefferson-cruz.org/",
            "facebook": "https://nelson.biz/"
        }
    ]
}
""".data(using: .utf8)!
