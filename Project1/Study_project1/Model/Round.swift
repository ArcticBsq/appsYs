//
//  Round.swift
//  Study_project1
//
//  Created by Илья Москалев on 03.06.2021.
//

import Foundation

class Round: RoundProtocol {
    
    var score: Int = 0
    
    var currentSecretValue: Int = 0
    
    init(secretValue: Int) {
        currentSecretValue = secretValue
    }
    
    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
}
