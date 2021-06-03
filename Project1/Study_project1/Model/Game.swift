//
//  Game.swift
//  Study_project1
//
//  Created by Илья Москалев on 03.06.2021.
//

import Foundation

class Game: GameProtocol {
    
    var score: Int {
           var totalScore: Int = 0
           for round in self.rounds {
               totalScore += round.score
           }
           return totalScore
       }
    
       var currentRound: RoundProtocol!
       private var rounds: [RoundProtocol] = []
       var secretValueGenerator: GeneratorProtocol
       private var roundsCount: Int!
       var isGameEnded: Bool {
           if roundsCount == rounds.count {
               return true
           } else {
               return false
           }
       }

       init(valueGenerator: GeneratorProtocol, rounds: Int) {
           secretValueGenerator = valueGenerator
           roundsCount = rounds
           startNewRound()
       }
       
       func restartGame() {
           rounds = []
           startNewRound()
       }

       func startNewRound() {
           let newSecretValue = self.getNewSecretValue()
           currentRound = Round(secretValue: newSecretValue)
           rounds.append( currentRound )
       }

       // Загадать и вернуть новое случайное значение
       private func getNewSecretValue() -> Int {
           return secretValueGenerator.getRandomValue()
       }
    
}
