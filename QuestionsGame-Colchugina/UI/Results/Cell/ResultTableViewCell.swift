//
//  ResultTableViewCell.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 31.10.2021.
//

import UIKit

final class ResultTableViewCell: UITableViewCell {
    
    //MARK: - Public properties
    static let reuseId = "ResultTableViewCell"
    
    //MARK: - Private properties
    private let percentLabel = UILabel()
    private let dateLabel = UILabel()
    private let questions = UILabel()
    
    //MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: ResultTableViewCell.reuseId)
        setViews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public properties
    func config (result: GameSession) {
        let percent = Double(result.rightAnswersCount) / Double(result.questionsCount) * 100
        if percent > 66 {
            percentLabel.backgroundColor = UIColor(red: 97/255, green: 199/255, blue: 115/255, alpha: 1)
        } else if percent < 33 {
            percentLabel.backgroundColor = UIColor(red: 234/255, green: 233/255, blue: 237/255, alpha: 1)
            percentLabel.textColor = .darkGray
        } else {
            percentLabel.backgroundColor = .systemYellow
        }
        percentLabel.text = String(format: "%.1f", percent) + "%"
        dateLabel.text = "Дата: \(result.date)"
        questions.text = "Вопросы: \(result.rightAnswersCount) / \(result.questionsCount)"
    }
    
    //MARK: - Private properties
    private func setViews() {
        self.addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            percentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            percentLabel.heightAnchor.constraint(equalToConstant: 70),
            percentLabel.widthAnchor.constraint(equalToConstant: 70),
            percentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        percentLabel.backgroundColor = UIColor(red: 97/255, green: 199/255, blue: 115/255, alpha: 1)
        percentLabel.layer.cornerRadius = 20
        percentLabel.layer.masksToBounds = true
        percentLabel.font = UIFont(name: "Avenir-Light", size: 20)
        percentLabel.textAlignment = .center
        percentLabel.textColor = .white
        
        self.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            dateLabel.leadingAnchor.constraint(equalTo: percentLabel.trailingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        dateLabel.font = UIFont(name: "Avenir-Light", size: 15)
        dateLabel.textColor = .darkGray
        
        self.addSubview(questions)
        questions.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questions.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            questions.leadingAnchor.constraint(equalTo: percentLabel.trailingAnchor, constant: 20),
            questions.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        questions.font = UIFont(name: "Avenir-Light", size: 15)
        questions.textColor = .darkGray
    }
    
}
