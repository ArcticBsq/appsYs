//
//  Protocols.swift
//  Study_project1
//
//  Created by Илья Москалев on 03.06.2021.
//

import Foundation

protocol GameProtocol {
    // Количество заработанных очков
    var score: Int { get }
    // текущий раунд
    var currentRound: RoundProtocol! { get }
    // Проверяет, окончена ли игра
    var isGameEnded: Bool { get }
    // Генератор случайного значения
    var secretValueGenerator: GeneratorProtocol { get }
    // Начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // Начинает новый раунд
    func startNewRound()
}

protocol RoundProtocol {
    var score: Int { get }
    var currentSecretValue: Int { get }
    
    func calculateScore(with: Int)
}

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}
