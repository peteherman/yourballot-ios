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
            "position": 2,
            "name": "April Johnson",
            "profile_photo": "https://www.alvarado.com/",
            "similarity": 0.9329179606750063
        },
        {
            "id": 3,
            "external_id": "cec5fefd-1019-48d2-829c-a71c02672fad",
            "position": 3,
            "name": "Erin Lin",
            "profile_photo": "https://burke.org/",
            "similarity": 0.9329179606750063
        }
    ]
}
""".data(using: .utf8)!
