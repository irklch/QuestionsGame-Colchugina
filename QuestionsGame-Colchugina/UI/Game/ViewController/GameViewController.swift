//
//  GameViewController.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import UIKit

final class GameViewController: UIViewController {
    
    //MARK: - Private properties
    private let questionTextView = UITextView()
    private var answerButtons = [UIButton](repeating: UIButton(), count: 4)
    private let answersCountLabel = UILabel()
    private let percentLabel = UILabel()
    private var gameSession = GameSession()
    private var currentQuestion = 0
    private let difficult = Game.shared.difficult
    weak var gameDelegate: GameDelegate?
    private var gameStrategy: CreateGameStrategy {
        switch difficult! {
        case .easy:
            return SimpleGameStrategy()
        case .hard:
            return RandomGameStrategy()
        }
    }
    private let careTaker = QuestionCaretaker()

    //MARK: - Lfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewQuestions()
        setDifficulty()
        addObservers()
        setViews()
    }
    
    //MARK: - Private methods

    private func loadNewQuestions() {
        let newQuestions = try? careTaker.loadGame()
        guard let questions = newQuestions else {return}
        for item in 0..<questions.count {
            if !questionsList.contains(where: {$0.question == questions[item].question}) {
                questionsList.append(questions[item])
            }
        }
    }

    private func setDifficulty() {
        questionsList = gameStrategy.createRandom(with: questionsList)
    }

    private func addObservers() {
        gameSession.rightAnswersCountObservable.addObserver(self, options: [.new]) { [weak self] (result, _) in
            guard let self = self else {return}
            self.answersCountLabel.text = "Пройдено вопросов: \(result)/\(questionsList.count)"
        }
        gameSession.percentAnswers.addObserver(self, options: [.new]) { [weak self] (result, _) in
            guard let self = self else {return}
            self.percentLabel.text = String(format: "%.1f", result) + "%"
        }
    }

    private func setViews() {
        view.backgroundColor =  UIColor(red: 244/255,
                                        green: 244/255,
                                        blue: 246/255,
                                        alpha: 1)
        
        let viewHeight = (view.frame.height / 2).rounded()

        view.addSubview(answersCountLabel)
        answersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answersCountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            answersCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answersCountLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        answersCountLabel.text = "Пройдено вопросов: 0/\(questionsList.count)"
        answersCountLabel.font = UIFont(name: "Avenir-Light", size: 15)

        view.addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            percentLabel.leadingAnchor.constraint(equalTo: answersCountLabel.trailingAnchor, constant: 20),
            percentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        percentLabel.text = "0%"
        percentLabel.font = UIFont(name: "Avenir-Light", size: 15)

        view.addSubview(questionTextView)
        questionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionTextView.topAnchor.constraint(equalTo: answersCountLabel.bottomAnchor, constant: 10),
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
        
        for item in 0..<4 {
            let answerHeight = ((viewHeight - 55)/4).rounded()
            let answer = UIButton()
            view.addSubview(answer)
            answer.translatesAutoresizingMaskIntoConstraints = false
            let botAnch = (-10 - CGFloat(item) * (answerHeight + 10)).rounded()
            
            NSLayoutConstraint.activate([
                answer.topAnchor.constraint(equalTo: questionTextView.bottomAnchor, constant:  -botAnch),
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
            let itemQ = questionsList[currentQuestion].answers[item]

            answer.setTitle(itemQ, for: .normal)

            answer.setTitleColor(.darkGray, for: .normal)
            answer.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
            answer.tag = item
            answer.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            answerButtons[item] = answer
        }
    }
    
    @objc
    private func answerTapped(_ sender: UIButton) {
        
        if sender.tag == questionsList[currentQuestion].rightAnswerIndex {
            sender.backgroundColor = UIColor(red: 97/255, green: 199/255, blue: 115/255, alpha: 1)
            sender.setTitleColor(.white, for: .normal)
            if currentQuestion == questionsList.count - 1 {
                currentQuestion += 1
                gameSession.questionsCount = questionsList.count
                gameSession.rightAnswersCount = currentQuestion
                showAlert(title: "Поздравляем 🥳", text: "Вы ответили на все вопросы верно")
                gameDelegate?.gameDidEnd(session: gameSession)
            } else {
                currentQuestion += 1
                gameSession.questionsCount = questionsList.count
                gameSession.rightAnswersCount = currentQuestion

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    guard let self = self else {return}
                    sender.setTitleColor(.darkGray, for: .normal)
                    sender.backgroundColor = .systemYellow
                    self.questionTextView.text = questionsList[self.currentQuestion].question
                    for item in 0..<4 {
                        let answer = questionsList[self.currentQuestion].answers[item]
                        self.answerButtons[item].setTitle(answer, for: .normal)
                    }
                }
            }
        }
        else {
            showAlert(title: "Ooops 😰", text: "Вы ответили неверно. Игра окончена")
            gameSession.questionsCount = questionsList.count
            gameSession.rightAnswersCount = currentQuestion
            gameDelegate?.gameDidEnd(session: gameSession)
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

//MARK: - Data
fileprivate var questionsList = [
    Question(question: "Как характеризуется свойство хранения, начальное знаяение которого не вычисляется до первого использования?",
             answers: ["Свойство хранения",
                       "Ленивое свойство хранения",
                       "Латентное свойство хранения",
                       "Пассивное свойство хранения"],
             rightAnswerIndex: 1),
    Question(question: "Перечисления, экземпляры которого являются ассоциативным значением одного или более кейсов перечисления",
             answers: ["Исходные перечисления",
                       "Рекурсивные перечисления",
                       "Сквозные перечисления",
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
