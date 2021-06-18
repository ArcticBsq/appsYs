//
//  TaskEditController.swift
//  To-Do Manager
//
//  Created by Илья Москалев on 14.06.2021.
//

import UIKit

class TaskEditController: UITableViewController {
    
    @IBOutlet var taskTitle: UITextField!
    
    @IBOutlet var taskTypeLabel: UILabel!
    
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    // Параметры задачи
    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    
    // Замыкание через которое передаются данные в TaskListController
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    // Словарь для установки значения taskTypeLabel по taskType переданному из TaskListController
    private var taskTitles: [TaskPriority:String] = [
        .important: "Важная",
        .normal: "Текущая"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        taskTitle.text = taskText
        taskTypeLabel.text = taskTitles[taskType]
        
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveTask))
    }
    @objc func saveTask() {
        var set = Set<Character>()
        // Получаем актуальное значение
        let title = taskTitle?.text ?? ""
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ? .completed : .planned
        
        for letter in title {
            set.insert(letter)
        }
        
        if (set.contains(" ") && set.count == 1) || set.isEmpty {
            let ac = UIAlertController(title: "Сорян", message: "Название не может быть пустым", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ОК", style: .cancel))
            present(ac, animated: true)
        } else {
            // Вызываем обработчик
            doAfterEdit?(title, type, status)
            // Возвращаемся к предыдущему экрану
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen" {
            // ссылка на контроллер назначения
            let destination = segue.destination as! TaskTypeController
            // передача выбранного типа
            destination.selectedType = taskType
            // передача обработчика выбора типа
            destination.doAfterTypeSelected = { [unowned self] selectedType in
                taskType = selectedType
                // обновляем метку с текущим типом
                taskTypeLabel?.text = taskTitles[taskType]
            }
        }
    }
}
