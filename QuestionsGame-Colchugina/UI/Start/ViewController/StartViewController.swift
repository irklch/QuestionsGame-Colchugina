//
//  StartViewController.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import UIKit

final class StartViewController: UIViewController {

    //MARK: - Private properties
    private let logoLabel = UILabel()
    private let playButton = UIButton()
    private let resultsButton = UIButton()

//MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }

    //MARK: - Private methods
    private func setViews() {
        view.backgroundColor = UIColor(red: 244/255,
                                       green: 244/255,
                                       blue: 246/255,
                                       alpha: 1)

        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            playButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        playButton.backgroundColor = .systemYellow
        playButton.layer.cornerRadius = 15
        playButton.setTitle("Играть", for: .normal)
        playButton.setTitleColor(.darkGray, for: .normal)
        playButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 26)
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        playButton.setBackgroundColor(color: UIColor(red: 246/255,
                                                     green: 225/255,
                                                     blue: 117/255,
                                                     alpha: 1),
                                      forState: .highlighted)
        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        playButton.layer.shadowRadius = 4
        playButton.layer.shadowOpacity = 0.1
        playButton.layer.shadowPath = UIBezierPath(rect: playButton.bounds).cgPath
        playButton.clipsToBounds = false
        playButton.addTarget(self, action: #selector(playGame), for: .touchUpInside)

        view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -110),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        logoLabel.font = UIFont(name: "Avenir-Medium", size: 80)
        logoLabel.text = "QGame"
        logoLabel.textColor = .systemYellow

        view.addSubview(resultsButton)
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultsButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            resultsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            resultsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            resultsButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        resultsButton.backgroundColor = .systemYellow
        resultsButton.layer.cornerRadius = 15
        resultsButton.setTitle("Результаты", for: .normal)
        resultsButton.setTitleColor(.darkGray, for: .normal)
        resultsButton.setBackgroundColor(color: UIColor(red: 246/255,
                                                        green: 225/255,
                                                        blue: 117/255,
                                                        alpha: 1),
                                         forState: .highlighted)
        resultsButton.titleLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        resultsButton.addTarget(self, action: #selector(presentResults), for: .touchUpInside)
        resultsButton.layer.shadowColor = UIColor.black.cgColor
        resultsButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        resultsButton.layer.shadowRadius = 4
        resultsButton.layer.shadowOpacity = 0.1
        resultsButton.layer.shadowPath = UIBezierPath(rect: resultsButton.bounds).cgPath
        resultsButton.clipsToBounds = false
    }

    @objc
    private func playGame() {
        let vc = GameViewController()
        present(vc, animated: true, completion: nil)
    }

    @objc
    private func presentResults() {
        let vc = ResultsViewController()
        present(vc, animated: true, completion: nil)
    }

}

