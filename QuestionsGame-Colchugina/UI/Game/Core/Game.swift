//
//  Game.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import Foundation

final class Game {
    //MARK: - Public properties
    static let shared = Game()
    
    //MARK: - Private properties
    private(set) var results: [GameResult] = [] {
        didSet {
            self.careTaker.saveGame(self.results)
        }
    }
    private var gameSession: GameSession?
    private let careTaker = GameCareTaker()
    
    //MARK: - Life cycle
    private init() {
        guard let oldResults = try? careTaker.loadGame() else {return}
        results = oldResults
    }
    
    //MARK: - Public methods
    func addGameSession(_ gameSession: GameSession) {
        self.gameSession = gameSession
        saveResult()
        self.gameSession = nil
    }
    
    //MARK: - Private properties
    private func saveResult() {
        guard let session = gameSession else {return}
        let result = GameResult(rightAnswersCount: session.rightAnswersCount, questionsCount: session.questionsCount)
        results.append(result)
    }
}
