//
//  GameCaretaker.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 31.10.2021.
//

import Foundation

final class GameCareTaker {

    typealias Memento = Data

    //MARK: - Private properties
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "game"
    
    //MARK: - Public methods
    func saveGame(_ result: [GameSession]) {
        guard let data: Memento = try? encoder.encode(result) else {return}
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func loadGame() -> [GameSession] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data,
              let result = try? decoder.decode([GameSession].self, from: data)
        else { return [] }
        return result
    }
    
}
