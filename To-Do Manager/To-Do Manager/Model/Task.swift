//
//  Task.swift
//  To-Do Manager
//
//  Created by Илья Москалев on 11.06.2021.
//

import Foundation

// Тип задачи
enum TaskPriority {
    // Текущая
    case normal
    // Важная
    case important
}

// Состояние задачи
enum TaskStatus: Int {
    // Запланированная
    case planned
    // Завершнная
    case completed
}

protocol TaskProtocol {
    // Название
    var title: String { get set }
    // Тип
    var type: TaskPriority { get set }
    // Статус
    var status: TaskStatus { get set }
}

// Сущность "Задача"
struct Task: TaskProtocol {
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}
