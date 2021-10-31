//
//  GameCaretaker.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 31.10.2021.
//

import Foundation

final class GameCareTaker {
    
    //MARK: - Public properties
    public enum Error: Swift.Error {
        case gameNotFound
    }
    
    //MARK: - Private properties
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "game"
    
    //MARK: - Public methods
    func saveGame(_ result: [GameResult]) {
        guard let data: Data = try? encoder.encode(result) else {return}
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadGame() throws -> [GameResult] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data,
              let result = try? decoder.decode([GameResult].self, from: data)
        else {
            throw Error.gameNotFound
        }
        return result
    }
    
}
