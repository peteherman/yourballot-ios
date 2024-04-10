//
//  TestQuestionData.swift
//  Your BallotTests
//
//  Created by Peter Herman on 3/19/24.
//

import Foundation

let allQuestions: Data = """
{
    "result_info": {
        "next": null,
        "previous": null,
        "total": 10
    },
    "result": [
        {
            "id": 1,
            "external_id": "20301c36-8ca3-436d-8e07-02df8f3e35ce",
            "name": "Healthcare is human right",
            "question": "Healthcare is a human right and no person should need to pay for healthcare",
            "issue": 1,
            "issue_name": "Healthcare"
        },
        {
            "id": 2,
            "external_id": "29ee1da2-a835-49e7-b3c4-130c78e376c4",
            "name": "Fed Gov't should ensure healthcare coverage",
            "question": "The federal government should be responsible for ensuring all American shave healthcare coverage",
            "issue": 1,
            "issue_name": "Healthcare"
        },
        {
            "id": 3,
            "external_id": "298dfc5c-bfa0-425a-97e6-634fa305613b",
            "name": "All Abortion is murder",
            "question": "All abortion should be viewed as murder and it should be outlawed",
            "issue": 2,
            "issue_name": "Abortion"
        },
        {
            "id": 4,
            "external_id": "3ae572bb-4a95-4195-868c-bdce9df9d149",
            "name": "No abortions after week 8",
            "question": "Abortions which occur after week 8 of pregnancy should be outlawed, regardless of the circumstances",
            "issue": 2,
            "issue_name": "Abortion"
        },
        {
            "id": 5,
            "external_id": "22046789-2e85-4981-a145-dbc27a5ac7fe",
            "name": "No waiting period for gun purchase",
            "question": "There should not be a waiting period to purchase a gun",
            "issue": 3,
            "issue_name": "Gun Control"
        },
        {
            "id": 6,
            "external_id": "f32c1683-dbe9-45ca-8d59-ebaf4e9cde57",
            "name": "No restrictions on ammo purchase",
            "question": "There should not be any restriction with respect to the amount of ammo a single individual can purchase at a time",
            "issue": 3,
            "issue_name": "Gun Control"
        },
        {
            "id": 7,
            "external_id": "9056656c-dca3-4c9b-97a0-86013b02e272",
            "name": "No gas vehicles after 2035",
            "question": "The government should prohibit the production of gas powered vehicles after the year 2035",
            "issue": 4,
            "issue_name": "Environment"
        },
        {
            "id": 8,
            "external_id": "927364d2-4186-4d8c-8054-4f86242fe073",
            "name": "Fed Gov't not doing enough to stop climate change",
            "question": "The federal government is not doing enough to reduce the effects of climate change",
            "issue": 4,
            "issue_name": "Environment"
        },
        {
            "id": 9,
            "external_id": "dc4cc703-d7e1-4798-bdc5-1fe03a77142f",
            "name": "Close border for short period of time",
            "question": "The federal government should close the border, at least for a short period of time so that the individuals currently in the system can be processed",
            "issue": 5,
            "issue_name": "Immigration"
        },
        {
            "id": 10,
            "external_id": "44e177f5-2334-46e4-9c08-6579f5483309",
            "name": "Restrict border",
            "question": "The federal government should more heavily restrict who is allowed through the border",
            "issue": 5,
            "issue_name": "Immigration"
        }
    ]
}
""".data(using: .utf8)!

let testVoterRemainingQuestionsData: Data = """
{
    "result_info": {
        "next": null,
        "previous": null,
        "total": 10
    },
    "result": [
        {
            "id": 1,
            "external_id": "20301c36-8ca3-436d-8e07-02df8f3e35ce",
            "name": "Healthcare is human right",
            "question": "Healthcare is a human right and no person should need to pay for healthcare",
            "issue": 1,
            "issue_name": "Healthcare"
        },
        {
            "id": 2,
            "external_id": "29ee1da2-a835-49e7-b3c4-130c78e376c4",
            "name": "Fed Gov't should ensure healthcare coverage",
            "question": "The federal government should be responsible for ensuring all American shave healthcare coverage",
            "issue": 1,
            "issue_name": "Healthcare"
        },
        {
            "id": 3,
            "external_id": "298dfc5c-bfa0-425a-97e6-634fa305613b",
            "name": "All Abortion is murder",
            "question": "All abortion should be viewed as murder and it should be outlawed",
            "issue": 2,
            "issue_name": "Abortion"
        },
        {
            "id": 4,
            "external_id": "3ae572bb-4a95-4195-868c-bdce9df9d149",
            "name": "No abortions after week 8",
            "question": "Abortions which occur after week 8 of pregnancy should be outlawed, regardless of the circumstances",
            "issue": 2,
            "issue_name": "Abortion"
        },
        {
            "id": 5,
            "external_id": "22046789-2e85-4981-a145-dbc27a5ac7fe",
            "name": "No waiting period for gun purchase",
            "question": "There should not be a waiting period to purchase a gun",
            "issue": 3,
            "issue_name": "Gun Control"
        },
        {
            "id": 6,
            "external_id": "f32c1683-dbe9-45ca-8d59-ebaf4e9cde57",
            "name": "No restrictions on ammo purchase",
            "question": "There should not be any restriction with respect to the amount of ammo a single individual can purchase at a time",
            "issue": 3,
            "issue_name": "Gun Control"
        },
        {
            "id": 7,
            "external_id": "9056656c-dca3-4c9b-97a0-86013b02e272",
            "name": "No gas vehicles after 2035",
            "question": "The government should prohibit the production of gas powered vehicles after the year 2035",
            "issue": 4,
            "issue_name": "Environment"
        },
        {
            "id": 8,
            "external_id": "927364d2-4186-4d8c-8054-4f86242fe073",
            "name": "Fed Gov't not doing enough to stop climate change",
            "question": "The federal government is not doing enough to reduce the effects of climate change",
            "issue": 4,
            "issue_name": "Environment"
        },
        {
            "id": 9,
            "external_id": "dc4cc703-d7e1-4798-bdc5-1fe03a77142f",
            "name": "Close border for short period of time",
            "question": "The federal government should close the border, at least for a short period of time so that the individuals currently in the system can be processed",
            "issue": 5,
            "issue_name": "Immigration"
        },
        {
            "id": 10,
            "external_id": "44e177f5-2334-46e4-9c08-6579f5483309",
            "name": "Restrict border",
            "question": "The federal government should more heavily restrict who is allowed through the border",
            "issue": 5,
            "issue_name": "Immigration"
        }
    ]
}
""".data(using: .utf8)!
