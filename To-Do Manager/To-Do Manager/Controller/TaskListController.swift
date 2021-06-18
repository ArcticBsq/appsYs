//
//  TaskListController.swift
//  To-Do Manager
//
//  Created by Илья Москалев on 11.06.2021.
//

import UIKit

class TaskListController: UITableViewController {

    var tasksStorage: TasksStorageProtocol = TasksStorage()
    // MARK: Сориторовка выполненные отправляются вниз
    var tasks: [TaskPriority: [TaskProtocol]] = [:] {
        didSet {
            // Cортировка списка задач
            for (tasksGroupPriority, tasksGroup) in tasks {
                tasks[tasksGroupPriority] = tasksGroup.sorted { task1, task2 in
                    let task1Position = taskStatusPosition.firstIndex(of: task1.status) ?? 0
                    let task2Position = taskStatusPosition.firstIndex(of: task2.status) ?? 0
                    return task1Position < task2Position
                }
            }
            // Сохранение задач
            var savingArray: [TaskProtocol] = []
            tasks.forEach { _, value in
                savingArray += value
            }
            tasksStorage.saveTasks(savingArray)
        }
    }
    
    var sectionsTypesPosition: [TaskPriority] = [.important, .normal]
    var taskStatusPosition: [TaskStatus] = [.planned, .completed]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Кнопка активации режима редактирования
        navigationItem.leftBarButtonItem = editButtonItem
        
    }

    func setTasks(_ tasksCollection: [TaskProtocol]) {
        // Подготовка коллекции с задачами
        // будем использовать только те задачи, для которых определена секция
        sectionsTypesPosition.forEach { taskType in
            tasks[taskType] = []
        }
        // Загрузка и разбор задач из хранилища
        tasksCollection.forEach { task in
            tasks[task.type]?.append(task)
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Количество ключей в словаре tasks
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Определяем приоритет задач, соответствующий текущей секции
        let taskType = sectionsTypesPosition[section]
        guard let currentTaskType = tasks[taskType] else { return 0 }
        
        return currentTaskType.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getConfiguredTaskCell_constraints(for: indexPath)
    }
    
    // Ячейка на основе Constraints
    private func getConfiguredTaskCell_constraints(for indexPath: IndexPath) -> UITableViewCell {
        // Загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellConstraints", for: indexPath)
        // Получаем данные о задаче, которую необходимо вывести в ячейке
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return cell
        }
        
        // Текстовая метка символа
        let symbolLabel = cell.viewWithTag(1) as? UILabel
        // Текстовая метка названия задачи
        let textLabel = cell.viewWithTag(2) as? UILabel
        
        // Изменяем символ в ячейке
        symbolLabel?.text = getSymbolForTask(with: currentTask.status)
        // Изменяем текст в ячейке
        textLabel?.text = currentTask.title
        
        // Изменяем цвет текства и символа
        if currentTask.status == .planned {
            textLabel?.textColor = .black
            symbolLabel?.textColor = .black
        } else {
            textLabel?.textColor = .lightGray
            symbolLabel?.textColor = .lightGray
        }
        return cell
    }
    
    // ячейка на основе стека
    private func getConfiguredTaskCell_stack(for indexPath: IndexPath) -> UITableViewCell {
        // загружаем прототип ячейки по идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellStack", for: indexPath) as! TaskCell
        // получаем данные о задаче, которые необходимо вывести в ячейке
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return cell
        }
        // изменяем текст в ячейке
        cell.title.text = currentTask.title
        // изменяем символ в ячейке
        cell.symbol.text = getSymbolForTask(with: currentTask.status)
        // изменяем цвет текста
        if currentTask.status == .planned {
            cell.title.textColor = .black
            cell.symbol.textColor = .black
        } else {
            cell.title.textColor = .lightGray
            cell.symbol.textColor = .lightGray
        }

        return cell
    }
    
    // Возвращаем символ для соответствующейго типа задачи
    private func getSymbolForTask(with status: TaskStatus) -> String {
        var resultSymbol: String
        if status == .planned {
            resultSymbol = "\u{25CB}"
        } else if status == .completed {
            resultSymbol = "\u{25C9}"
        } else {
            resultSymbol = ""
        }
        return resultSymbol
    }
    
    // Заголовок секции
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        let tasksType = sectionsTypesPosition[section]
        if tasksType == .important {
            title = "Важные"
        } else {
            title = "Текущие"
        }
        return title
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var title: String?
        
        if section == 0 && tasks[.important]?.count == 0 {
            title = "Важных задач нет"
        } else if section == 1 && tasks[.normal]?.count == 0 {
            title = "Текущих задач нет"
        }
        return title
    }
    
    // MARK: Обработка нажатия на row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. Проверяем существование задачи
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else { return }
        // 2. Убеждаемся, что задача не является выполненной
        guard tasks[taskType]![indexPath.row].status == .planned else {
            // Снимаем выделение со строки
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        // 3. Отмечаем задачу как выполненную
        tasks[taskType]![indexPath.row].status = .completed
        // 4. Перезагружаем секцию таблицы
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    // MARK: Перевод задачи в статус запланировано по свайпу
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Получаем данные о задаче, которую необходимо перевести в статус "Запланирована"
        let taskType = sectionsTypesPosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else { return nil }
        
        // Действие для изменения статуса на "Запланирована"
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Не выполнена") { _, _, _ in
            self.tasks[taskType]![indexPath.row].status = .planned
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
        
        // Действие для перехода к экрану редактирования
        let actionEditInstance = UIContextualAction(style: .normal, title: "Изменить") { _, _, _ in
            // Загрузка сцены со StoryBoard
            let editScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TaskEditController") as! TaskEditController
            // Передача значений редактируемой задачи
            editScreen.taskText = self.tasks[taskType]![indexPath.row].title
            editScreen.taskType = self.tasks[taskType]![indexPath.row].type
            editScreen.taskStatus = self.tasks[taskType]![indexPath.row].status
            // Передача обработчика для сохранения задачи
            editScreen.doAfterEdit = { [unowned self] title, type, status in
                let editedTask = Task(title: title, type: type, status: status)
                tasks[taskType]![indexPath.row] = editedTask
                tableView.reloadData()
            }
            // Переход к экрану редактирования
            self.navigationController?.pushViewController(editScreen, animated: true)
        }
        // Изменяем цвет фона кнопки
        actionEditInstance.backgroundColor = .darkGray
        
        // Cоздаем объект описывающий доступные действия в зависимости от статуса задачи будет отображено 1 или 2 действия
        let actionsConfiguration: UISwipeActionsConfiguration
        if tasks[taskType]![indexPath.row].status == .completed {
            actionsConfiguration = UISwipeActionsConfiguration(actions: [actionSwipeInstance, actionEditInstance])
        } else {
            actionsConfiguration = UISwipeActionsConfiguration(actions: [actionEditInstance])
        }
        
        // Возвращаем настроенный объект
        return actionsConfiguration
    }
    
    // MARK: Удаляем строку, соответсвующую задаче в режиме edit
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let taskType = sectionsTypesPosition[indexPath.section]
        // Удаляем задачу
        tasks[taskType]?.remove(at: indexPath.row)
        // Удаляем строку, соответствующую задаче
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: Ручная сортировка списка задач
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Секция из которой происходит перемещение
        let taskTypeFrom = sectionsTypesPosition[sourceIndexPath.section]
        // Секция в которую осуществляется перемещение
        let taskTypeTo = sectionsTypesPosition[destinationIndexPath.section]
        
        // Безопасно извлекаем задачу, чем копируем ее
        guard let movedTask = tasks[taskTypeFrom]?[sourceIndexPath.row] else { return }
        
        // Удаляем задачу из места, откуда она перенесена
        tasks[taskTypeFrom]!.remove(at: sourceIndexPath.row)
        // Вставляем новую задачу на новую позицию
        tasks[taskTypeTo]!.insert(movedTask, at: destinationIndexPath.row)
        // Если секция изменилась, изменяем тип задачи в соответствии с новой позицией
        if taskTypeFrom != taskTypeTo {
            tasks[taskTypeTo]![destinationIndexPath.row].type = taskTypeTo
        }
        // Обновляем данные
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateScreen" {
            let destination = segue.destination as! TaskEditController
            destination.doAfterEdit = { [unowned self] title, type, status in
                let newTask = Task(title: title, type: type, status: status)
                tasks[type]?.append(newTask)
                tableView.reloadData()
            }
        }
    }
    
    
}
