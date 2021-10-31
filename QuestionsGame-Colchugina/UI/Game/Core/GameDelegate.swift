//
//  GameDelegate.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import Foundation

protocol GameDelegate: AnyObject {
    func gameDidEnd(questionsCount: Int, rightAnswersCount: Int)
}
