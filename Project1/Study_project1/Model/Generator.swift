//
//  Generator.swift
//  Study_project1
//
//  Created by Илья Москалев on 03.06.2021.
//

import Foundation

class Generator: GeneratorProtocol {
    
    
    private let startRangeValue: Int
    private let endRangeValue: Int
    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
    }
    
    func getRandomValue() -> Int {
        (startRangeValue...endRangeValue).randomElement()!
    }
}
