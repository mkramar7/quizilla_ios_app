//
//  Question.swift
//  Quizilla
//
//  Created by Marko Kramar on 09/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

struct Question : Codable {
    let id: String
    let question: String
    let category: String
    let answers: [Answer]
    let correctAnswerId: Int
}
