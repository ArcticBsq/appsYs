//
//  Task.swift
//  Cards
//
//  Created by Илья Москалев on 25.06.2021.
//

import Foundation

enum TaskType {
    // выбрать количество пар карт
    case pairsOfCards
    // выбрать типы карт (фигуры), используемые в игре
    case figuresOfCards
    // выбрать цвета карт
    case colorsOfCards
    // выбрать узоры обратной стороны карты
    case backPictureOfCards
}

protocol TaskProtocol {
    // название
    var title: String { get }
    // тип
    var type: TaskType { get }
}

struct Task: TaskProtocol {
    var title: String
    var type: TaskType
}
