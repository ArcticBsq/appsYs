//
//  Card.swift
//  Cards
//
//  Created by Илья Москалев on 24.06.2021.
//

import UIKit

// типы фигур карт
enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
    case emptyCircle
}

// цвета карт
enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

// игральная карточка
typealias Card = (type: CardType, color: CardColor)
