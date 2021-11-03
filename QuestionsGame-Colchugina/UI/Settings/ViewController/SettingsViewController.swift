//
//  SettingsViewController.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 02.11.2021.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {

    //MARK: - Private properties
    private let titleLabel = UILabel()
    private let selectDifficultLabel = UILabel()
    private let difficultSegment = UISegmentedControl(items: ["Легко", "Сложно"])
    private let newQuestionButton = UIButton()

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
        titleLabel.text = "Настройки"
        titleLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        titleLabel.textColor = UIColor(red: 138/255, green: 138/255, blue: 141/255, alpha: 1)

        let lineView = UIView(frame: CGRect(x: 30, y: 45, width: view.frame.width, height: 0.6))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.separator.cgColor
        view.addSubview(lineView)

        view.addSubview(selectDifficultLabel)
        selectDifficultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectDifficultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            selectDifficultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            selectDifficultLabel.widthAnchor.constraint(equalToConstant: 170)
        ])
        selectDifficultLabel.text = "Выберите сложность"
        selectDifficultLabel.font = UIFont(name: "Avenir-Light", size: 15)
        selectDifficultLabel.textColor = .darkGray

        view.addSubview(difficultSegment)
        difficultSegment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            difficultSegment.centerYAnchor.constraint(equalTo: selectDifficultLabel.centerYAnchor),
            difficultSegment.leadingAnchor.constraint(equalTo: selectDifficultLabel.trailingAnchor, constant: 0),
            difficultSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        difficultSegment.selectedSegmentIndex = Game.shared.difficult?.rawValue ?? 0
        difficultSegment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        view.addSubview(newQuestionButton)
        newQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newQuestionButton.topAnchor.constraint(equalTo: difficultSegment.bottomAnchor, constant: 20),
            newQuestionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            newQuestionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = UIFont(name: "Avenir-Medium", size: 15)
        config.attributedTitle = AttributedString("Добавить новый вопрос", attributes: container)
        config.image = UIImage(systemName: "plus.square.fill")
        config.imagePlacement = .trailing
        config.baseForegroundColor = .systemYellow
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 15)
        config.imagePadding = 10
        newQuestionButton.contentHorizontalAlignment = .left
        newQuestionButton.configuration = config
        newQuestionButton.addTarget(self, action: #selector(addNewQuestion), for: .touchUpInside)
    }

    @objc
    private func segmentedControlValueChanged() {
        Game.shared.difficult = Difficulty(rawValue: difficultSegment.selectedSegmentIndex) ?? .easy
    }

    @objc
    private func addNewQuestion() {
        let vc = NewQuestionViewController()
        present(vc, animated: true, completion: nil)
    }

}
