//
//  NewQuestionViewController.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 03.11.2021.
//

import UIKit

final class NewQuestionViewController: UIViewController {

    //MARK: - Private properties
    private let titleLabel = UILabel()
    private let questionTextField = UITextField()
    private var answerTextFields = [UITextField]()
    private var rightCheckBoxButtons = [UIButton]()
    private let saveButton = UIButton()
    private var isChecked = false
    private var rightAnswer = 0
    private let careTaker = QuestionCaretaker()
    private var questions = [Question]()
    private enum AlertType {
        case append, error
    }

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }

    //MARK: - Private methods
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        titleLabel.text = "Добавить новый вопрос"
        titleLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        titleLabel.textColor = UIColor(red: 138/255, green: 138/255, blue: 141/255, alpha: 1)
        
        let lineView = UIView(frame: CGRect(x: 30, y: 45, width: view.frame.width, height: 0.6))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.separator.cgColor
        view.addSubview(lineView)
        
        let textFieldHeight = CGFloat(50)
        
        view.addSubview(questionTextField)
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            questionTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
        questionTextField.placeholder = "Вопрос"
        questionTextField.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        questionTextField.font = UIFont(name: "Avenir-Light", size: 15)
        questionTextField.textColor = .darkGray
        questionTextField.borderStyle = .roundedRect
        
        for item in 0..<4 {
            let textField = UITextField()
            let checkBox = UIButton()
            let botAnch = (-10 - CGFloat(item) * (textFieldHeight + 10)).rounded()
            
            view.addSubview(checkBox)
            checkBox.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                checkBox.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: -botAnch),
                checkBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                checkBox.heightAnchor.constraint(equalToConstant: textFieldHeight),
                checkBox.widthAnchor.constraint(equalToConstant: textFieldHeight - 20)
            ])
            checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
            checkBox.tag = item
            checkBox.addTarget(self, action: #selector(checkRightAnswer(_:)), for: .touchUpInside)
            checkBox.setImage(UIImage(systemName: "checkmark.circle"), for: .focused)
            rightCheckBoxButtons.append(checkBox)
            
            view.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: -botAnch),
                textField.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                textField.heightAnchor.constraint(equalToConstant: textFieldHeight)
            ])
            textField.placeholder = "Ответ \(item + 1)"
            textField.tag = item
            textField.font = UIFont(name: "Avenir-Light", size: 15)
            textField.textColor = .darkGray
            textField.borderStyle = .roundedRect
            textField.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
            answerTextFields.append(textField)
        }
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        var config = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont(name: "Avenir-Medium", size: 20)
        config.attributedTitle = AttributedString("Сохранить", attributes: container)
        config.baseBackgroundColor = .systemYellow
        config.baseForegroundColor = .darkGray
        config.titleAlignment = .center
        
        saveButton.configuration = config
        
        saveButton.layer.cornerRadius = 15
        saveButton.addTarget(self, action: #selector(addQuestion), for: .touchUpInside)
    }
    
    @objc
    private func checkRightAnswer(_ sender: UIButton) {
        if isChecked {
            rightCheckBoxButtons.forEach { $0.setImage(UIImage(systemName: "circle"), for: .normal)}
            answerTextFields.forEach { $0.backgroundColor = UIColor(red: 247/255,
                                                                    green: 247/255,
                                                                    blue: 247/255,
                                                                    alpha: 1)
                $0.textColor = .darkGray
            }
        }
        sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        answerTextFields[sender.tag].backgroundColor = UIColor(red: 97/255,
                                                               green: 199/255,
                                                               blue: 115/255,
                                                               alpha: 1)
        answerTextFields[sender.tag].textColor = .white
        rightAnswer = sender.tag
        isChecked = true
    }
    
    @objc
    private func addQuestion() {
        guard questionTextField.text != "",
              answerTextFields.allSatisfy({ $0.text != ""}),
              isChecked
        else {
            showAlert(title: "Ошибка!", messege: "Кажется, вы заполнили не все поля", alertType: .error)
            return
        }
        
        let answers = answerTextFields.compactMap {$0.text}
        let question = Question(question: questionTextField.text!, answers: answers, rightAnswerIndex: rightAnswer)
        questions.append(question)
        showAlert(title: "Успешно!", messege: "Новый вопрос сохранён", alertType: .append)
    }
    
    private func showAlert(title: String, messege: String, alertType: AlertType) {
        let alert = UIAlertController(title: title,
                                      message: messege, preferredStyle: .alert)
        switch alertType {
        case .append:
            let actionClose = UIAlertAction(title: "Закрыть", style: .cancel, handler: { [weak self] _ in
                guard let self = self else {return}
                self.careTaker.saveGame(self.questions)
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            })
            let actionContinue = UIAlertAction(title: "Добавить ещё", style: .default, handler: { [weak self] _ in
                guard let self = self else {return}
                self.questionTextField.text = ""
                self.answerTextFields.forEach {
                    $0.backgroundColor = UIColor(red: 247/255,
                                                 green: 247/255,
                                                 blue: 247/255,
                                                 alpha: 1)
                    $0.textColor = .darkGray
                    $0.text = ""
                }
                self.rightCheckBoxButtons.forEach { $0.setImage(UIImage(systemName: "circle"), for: .normal)}
                self.isChecked = false
            })
            alert.addAction(actionContinue)
            alert.addAction(actionClose)
        case .error:
            let actionContinue = UIAlertAction(title: "Продолжить", style: .default, handler: nil)
            alert.addAction(actionContinue)
        }
        present(alert, animated: true, completion: nil)
    }
    
}



