//
//  GameSession.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import Foundation

final class GameSession: Codable {

    
    //MARK: - Public properties
    var rightAnswersCount: Int = 0 {
        didSet {
            rightAnswersCountObservable.value = rightAnswersCount
            percentAnswers.value = Double(rightAnswersCount) / Double(questionsCount) * 100
        }
    }

    var questionsCount: Int = 0
    var rightAnswersCountObservable = Observable<Int>(0)
    let percentAnswers = Observable<Double>(0.0)

    enum CodingKeys: String, CodingKey {
        case rightAnswersCount
        case questionsCount
        case date
    }

    //MARK: - Private properties
    private(set) var date: Date = Date()
}



