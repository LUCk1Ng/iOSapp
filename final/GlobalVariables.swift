//
//  GlobalVariables.swift
//  final
//
//  Created by Alexandru Bargan on 5/23/20.
//  Copyright © 2020 Catalin. All rights reserved.
//

import Foundation

struct Constants {
    static let questionsURL:String = "xxhttps://opentdb.com/api.php?amount=1"
}

struct Response : Codable
{
    let response_code: Int
    let results: Array<Result>
}

struct Result :Codable
{
    let category: String
    //type":"multiple",
    //"difficulty":"easy",
    let question: String
    let correct_answer: String
    let incorrect_answers: Array<String>
}


