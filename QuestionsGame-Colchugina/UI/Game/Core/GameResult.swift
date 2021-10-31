//
//  GameResult.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 31.10.2021.
//

import Foundation

final class GameResult: Codable {

    //MARK: - Private properties
    private(set) var percentAnswers = 0.0
    private(set) var questionsCount = 0
    private(set) var rightAnswersCount = 0
    private(set) var date = Date()

    //MARK: - Life cycle
    init(rightAnswersCount: Int, questionsCount: Int) {
        self.rightAnswersCount = rightAnswersCount
        self.questionsCount = questionsCount
        self.percentAnswers = Double(rightAnswersCount) / Double(questionsCount) * 100
        self.date = Date.now
    }
    
}
