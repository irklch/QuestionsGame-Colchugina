//
//  QuestionCaretaker.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 03.11.2021.
//

import Foundation

final class QuestionCaretaker {

    typealias Memento = Data

    //MARK: - Public properties
    public enum Error: Swift.Error {
        case questionNotFound
    }

    //MARK: - Private properties
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "question"

    //MARK: - Public methods
    func saveGame(_ result: [Question]) {
        guard let data: Memento = try? encoder.encode(result) else {return}
        UserDefaults.standard.set(data, forKey: key)
    }

    func loadGame() throws -> [Question] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data,
              let result = try? decoder.decode([Question].self, from: data)
        else {
            throw Error.questionNotFound
        }
        return result
    }

}
