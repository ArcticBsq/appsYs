//
//  SettingsController.swift
//  Cards
//
//  Created by Илья Москалев on 25.06.2021.
//

import UIKit

class SettingsController: UITableViewController {

    var tasks: [TaskType: [TaskProtocol]] = [
        .pairsOfCards: [Task(title: "Количество пар одинаковых карт", type: .pairsOfCards)],
        .figuresOfCards: [Task(title: "Типы фигур", type: .figuresOfCards)],
        .colorsOfCards: [Task(title: "Выбрать цвета карт", type: .colorsOfCards)],
        .backPictureOfCards: [Task(title: "Узоры обратной стороны", type: .backPictureOfCards)]
    ]
    
    let sectionsTypesPosition: [TaskType] = [.pairsOfCards, .figuresOfCards, .colorsOfCards, .backPictureOfCards]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = #colorLiteral(red: 0.8979415298, green: 0.8980956674, blue: 0.8979316354, alpha: 1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tasks.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else { return cell }

        cell.textLabel?.text = currentTask.title
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "System", size: 22)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        var taskType = sectionsTypesPosition[section]
        
        if taskType == .pairsOfCards {
            title = "Количество пар одинаковых карт"
        } else if taskType == .figuresOfCards {
            title = "Типы фигур"
        } else if taskType == .colorsOfCards {
            title = "Выбрать цвета карт"
        } else {
            title = "Узоры обратной стороны"
        }
        return title 
    }
    
    
}
