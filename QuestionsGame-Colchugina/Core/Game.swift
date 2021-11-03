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
    private let careTaker = GameCareTaker()
    var difficult = Difficulty(rawValue: 0)
    
    private var session = [GameSession]() {
        didSet {
            self.careTaker.saveGame(self.session)
        }
    }
    
    //MARK: - Life cycle
    init() {
        self.session = careTaker.loadGame()
    }
    
    //MARK: - Public methods
    func addSession(_ session: GameSession) {
        self.session.append(session)
    }
    
}
