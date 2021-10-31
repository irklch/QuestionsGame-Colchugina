//
//  ResultsViewController.swift
//  QuestionsGame-Colchugina
//
//  Created by Ирина Кольчугина on 30.10.2021.
//

import UIKit

final class ResultsViewController: UITableViewController {
    
    //MARK: - Prrivate properties
    private let careTaker = GameCareTaker()
    private var results = [GameResult]()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        loadResults()
    }
    
    //MARK: - Table data sourse
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Результаты"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.reuseId, for: indexPath) as! ResultTableViewCell
        cell.config(result: results[indexPath.row])
        return cell
    }
    
    //MARK: - Private mathods
    private func registerCell() {
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseId)
    }
    
    private func loadResults() {
        guard let result = try? careTaker.loadGame() else {return}
        self.results = result.reversed()
    }
    
}
