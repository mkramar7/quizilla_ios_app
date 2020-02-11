//
//  Question.swift
//  Quizilla
//
//  Created by Marko Kramar on 09/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation

struct Question : Codable {
    let id: Int64
    let question: String
    let category: Category
    let answers: [Answer]
    let correctAnswerId: Int
}
