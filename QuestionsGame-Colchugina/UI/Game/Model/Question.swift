//
//  Questions.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import Foundation

struct Question: Codable {
    var question: String
    var answers: [String]
    var rightAnswerIndex: Int
}
