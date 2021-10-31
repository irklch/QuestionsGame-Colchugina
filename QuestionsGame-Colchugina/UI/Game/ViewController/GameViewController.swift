//
//  GameViewController.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Private properties
    private let gameSession = GameSession()
    private let questionTextView = UITextView()
    private var answers = [UIButton](repeating: UIButton(), count: 4)
    private var currentQuestion = 0
    
    //MARK: - Lfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSession.delegate = self
        setViews()
    }
    
    //MARK: - Private methods
    private func setViews() {
        view.backgroundColor =  UIColor(red: 244/255,
                                        green: 244/255,
                                        blue: 246/255,
                                        alpha: 1)
        
        let viewHeight = (view.frame.height / 2).rounded()
        
        for item in 0..<4 {
            let answerHeight = ((viewHeight - 55)/4).rounded()
            let answer = UIButton()
            view.addSubview(answer)
            answer.translatesAutoresizingMaskIntoConstraints = false
            let botAnch = (-25 - CGFloat(item) * (answerHeight + 10)).rounded()
            
            NSLayoutConstraint.activate([
                answer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  botAnch),
                answer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                answer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                answer.heightAnchor.constraint(equalToConstant: answerHeight)
            ])
            answer.backgroundColor = .systemYellow
            answer.layer.cornerRadius = 20
            answer.layer.shadowOffset = CGSize(width: 0, height: 3)
            answer.layer.shadowColor = UIColor.black.cgColor
            answer.layer.shadowOpacity = 0.1
            answer.layer.shadowRadius = 4
            answer.layer.shadowPath = UIBezierPath(rect: answer.bounds).cgPath
            answer.clipsToBounds = false
            answer.setTitle(questionsList[currentQuestion].answers[item], for: .normal)
            answer.setTitleColor(.darkGray, for: .normal)
            answer.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
            let indexInArray = abs(item - 3)
            answer.tag = indexInArray
            answer.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            answers[indexInArray] = answer
        }
        
        view.addSubview(questionTextView)
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            questionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -viewHeight - 10)
        ])
        questionTextView.layer.cornerRadius = 20
        questionTextView.layer.shadowColor = UIColor.black.cgColor
        questionTextView.layer.shadowOffset = CGSize(width: 0, height: 3)
        questionTextView.layer.shadowRadius = 4
        questionTextView.layer.shadowOpacity = 0.1
        questionTextView.layer.shadowPath = UIBezierPath(rect: questionTextView.bounds).cgPath
        questionTextView.clipsToBounds = false
        questionTextView.text = questionsList[currentQuestion].question
        questionTextView.textAlignment = .center
        questionTextView.contentInset.top = viewHeight/4
        questionTextView.font = UIFont(name: "Avenir-Light", size: 20)
        
    }
    
    @objc
    private func answerTapped(_ sender: UIButton) {
        
        if sender.tag == questionsList[currentQuestion].rightAnswerIndex {
            sender.backgroundColor = .green
            if currentQuestion == questionsList.count - 1 {
                gameDidEnd(questionsCount: questionsList.count, rightAnswersCount: currentQuestion)
                showAlert(title: "Поздравляем 🥳", text: "Вы ответили на все вопросы верно")
            } else {
                currentQuestion += 1
            }
        }
        else {
            showAlert(title: "Ooops 😰", text: "Вы ответили неверно. Игра окончена")
            gameDidEnd(questionsCount: questionsList.count, rightAnswersCount: currentQuestion)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else {return}
            
            sender.backgroundColor = .systemYellow
            self.questionTextView.text = questionsList[self.currentQuestion].question
            for item in 0..<4 {
                let answer = questionsList[self.currentQuestion].answers[item]
                self.answers[item].setTitle(answer, for: .normal)
            }
        }
    }
    
    private func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title,
                                      message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.dismiss(animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - Extension
extension GameViewController: GameDelegate {
    func gameDidEnd(questionsCount: Int, rightAnswersCount: Int) {
        gameSession.gameDidEnd(questionsCount: questionsCount, rightAnswersCount: rightAnswersCount)
    }
    
}

//MARK: - Data
fileprivate let questionsList = [
    Question(question: "Как характеризуется свойство хранения, начальное знаяение которого не вычисляется до первого использования?",
             answers: ["Свойство хранения",
                       "Ленивое свойство хранения",
                       "Латентное свойство хранения",
                       "Пассивное свойство хранения"],
             rightAnswerIndex: 1),
    Question(question: "Перечисления, экземпляры которого являются ассоциативным значением одного или более кейсов перечисления",
             answers: ["Исходные перечисления",
                       "Рекурсивные перечисления",
                       "Квозные перечисления",
                       "Ассоциативные перечисления"],
             rightAnswerIndex: 1),
    Question(question: "Какому паттерну присущи данные преимущества: уменьшает зависимость между клиентом и обработчиками, реализует принцип единтсвенной обязанности, реализует принцип открытости/закрытости",
             answers: ["Bridge",
                       "Composite",
                       "Chain of Responsibility",
                       "Adapter"],
             rightAnswerIndex: 2),
    Question(question: "Если массив или словарь присвоены переменной, можем ли мы их изменить?",
             answers: ["Только добавлять элементы",
                       "Нет",
                       "Только удалять элементы",
                       "Да"],
             rightAnswerIndex: 3),
    Question(question: "Выберите правильное создание словаря через литерал словаря",
             answers: ["var a: [Int: String] = [0: \"Name\"]",
                       "var b = [Int: String](1: \"Name\")",
                       "var c: <Int: String>[0: \"Name\"]",
                       "var d: (Int: String)[0: \"Name\"]"],
             rightAnswerIndex: 0),
    Question(question: "После указания этого ключевого слова к методу структуры или перечисления, он может изменить свои свойства изнутри метода",
             answers: ["public",
                       "private",
                       "static",
                       "mutating"],
             rightAnswerIndex: 3),
]
