//
//  TestVoterProfileData.swift
//  Your BallotTests
//
//  Created by Peter Herman on 6/25/24.
//

import Foundation
let testVoterProfileData = """
{
  "result_info": {
    "next": null,
    "previous": null,
    "success": true,
    "errors": [],
    "total": 0
  },
  "result": {
    "id": 7,
    "issue_views": {
      "Healthcare": 0.0,
      "Abortion": 0.0,
      "Gun Control": 0.0,
      "Environment": 0.0,
      "Immigration": 0.0
    },
    "email": "test4@mail.com",
    "created": "2024-06-19T11:50:35.709105Z",
    "external_id": "2c880964-b14b-4c6b-b0dd-093cb4297697",
    "age": null,
    "ethnicity": "Choose not to share",
    "gender": "Choose not to share",
    "race": "Choose not to share",
    "political_identity": "Middle",
    "political_party": "choose_not_to_share",
    "zipcode": "12831",
    "user": 8
  }
}
""".data(using: .utf8)!
