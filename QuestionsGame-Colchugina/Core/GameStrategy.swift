//
//  GameStrategy.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 02.11.2021.
//

import Foundation

protocol CreateGameStrategy {
    func createRandom(with questions: [Question]) -> [Question]
}

struct SimpleGameStrategy: CreateGameStrategy {
    func createRandom(with questions: [Question]) -> [Question] {
        return questions
    }

}

struct RandomGameStrategy: CreateGameStrategy {
    func createRandom(with questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
