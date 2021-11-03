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
    private let settingsButton = UIButton()

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

        var playConfig = UIButton.Configuration.filled()
        playConfig.baseBackgroundColor = .systemYellow
        playConfig.baseForegroundColor = .darkGray
        var playContainer = AttributeContainer()
        playContainer.font = UIFont(name: "Avenir-Medium", size: 26)
        playConfig.attributedTitle = AttributedString("Играть", attributes: playContainer)
        playConfig.titleAlignment = .center

        playButton.configuration = playConfig

        playButton.layer.cornerRadius = 15
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
            resultsButton.widthAnchor.constraint(equalToConstant: 250),
            resultsButton.heightAnchor.constraint(equalToConstant: 70)
        ])

        var resultConfig = UIButton.Configuration.filled()
        resultConfig.baseBackgroundColor = .systemYellow
        resultConfig.baseForegroundColor = .darkGray
        var resultContainer = AttributeContainer()
        resultContainer.font = UIFont(name: "Avenir-Light", size: 20)
        resultConfig.attributedTitle = AttributedString("Результаты", attributes: resultContainer)
        resultConfig.titleAlignment = .center

        resultsButton.configuration = resultConfig

        resultsButton.layer.cornerRadius = 15
        resultsButton.addTarget(self, action: #selector(presentResults), for: .touchUpInside)

        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            settingsButton.leadingAnchor.constraint(equalTo: resultsButton.trailingAnchor, constant: 10),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            settingsButton.heightAnchor.constraint(equalToConstant: 70)
        ])

        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "gearshape")
        config.baseForegroundColor = .darkGray
        config.baseBackgroundColor = .systemYellow
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 25)

        settingsButton.configuration = config
        
        settingsButton.layer.cornerRadius = 15
        settingsButton.addTarget(self, action: #selector(presentSettings), for: .touchUpInside)
    }

    @objc
    private func playGame() {
        let vc = GameViewController()
        vc.gameDelegate = self
        present(vc, animated: true, completion: nil)
    }

    @objc
    private func presentResults() {
        let vc = ResultsViewController()
        present(vc, animated: true, completion: nil)
    }

    @objc
    private func presentSettings() {
        let vc = SettingsViewController()
        vc.sheetPresentationController?.detents = [.medium(), .large()]
        present(vc, animated: true, completion: nil)
    }

}

//MARK: - Extension
extension StartViewController: GameDelegate {
    func gameDidEnd(session: GameSession) {
        Game.shared.addSession(session)
    }
}

