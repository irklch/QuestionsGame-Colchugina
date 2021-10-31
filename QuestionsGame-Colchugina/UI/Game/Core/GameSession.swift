//
//  GameSession.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import Foundation

final class GameSession {
    
    //MARK: - Public properties
    weak var delegate: GameDelegate?
    
    //MARK: - Private properties
    private(set) var rightAnswersCount = 0
    private(set) var questionsCount = 0
    
}

extension GameSession: GameDelegate {
    
    //MARK: - Public mathods
    func gameDidEnd(questionsCount: Int, rightAnswersCount: Int) {
        self.questionsCount = questionsCount
        self.rightAnswersCount = rightAnswersCount
        Game.shared.addGameSession(self)
    }
    
}
