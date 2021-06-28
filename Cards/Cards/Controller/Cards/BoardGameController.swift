//
//  BoardGameController.swift
//  Cards
//
//  Created by Илья Москалев on 24.06.2021.
//

import UIKit

class BoardGameController: UIViewController {
    
    // количество пар уникальных карточек
    var cardsPairsCounts = 8
    // сущность "Игра"
    lazy var game: Game = getNewGame()
    
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
    
    override func loadView() {
        super.loadView()
        // Добавляем кнопку новой игры на сцену
        view.addSubview(startButtonView)
        // Добавляем игровое поле на сцену
        view.addSubview(boardGameView)
        print(boardGameView.frame)
        view.addSubview(flipCards)
        view.addSubview(menuButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
// MARK: Кнопка назад
    lazy var menuButton = getBackButton()
    
    private func getBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: 50, height: 50))
        
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        
        button.frame.origin.y = topPadding
        
        button.setTitle("Menu", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        
        return button
    }
    
    @objc func openMenu() {
        navigationController?.popToRootViewController(animated: true)
    }
    
// MARK: Задание 3 кнопка переворота всех карт
    lazy var flipCards = getFlipCardsButtonView()
    
    private func getFlipCardsButtonView() -> UIButton {
        let button = UIButton(frame: CGRect(x: 330, y: 0, width: 50, height: 50))
        
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        
        button.frame.origin.y = topPadding
//        button.frame.origin.x = view.center.x + 135
        
        button.setTitle("Flip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        // устанавливаем цвет текста для нажатого состояния
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        // 4
        // подключаем обработчик нажатия на кнопку
        button.addTarget(nil, action: #selector(flipAll(_:)), for: .touchUpInside)
        
        return button
    }
    // переворот все=х карт
    @objc func flipAll(_ sender: UIButton) {
        if flippedCards.isEmpty {
            for card in cardViews {
                (card as! FlippableView).flipAll()
            }
            checkStatus()
        } else {
            let alreadyFlippedCard = flippedCards.first
            for card in cardViews {
                if card != alreadyFlippedCard {
                    (card as! FlippableView).flipAll()
                }
            }
            flippedCards = []
            checkStatus()
        }
    }
    // фикс бага с переворотом карт путем блокировки воздействия, если все перевернуты лицом вверх
    private func checkStatus() {
        var flipped = 0
        for card in cardViews {
            if (card as! FlippableView).isFlipped {
                flipped += 1
            }
        }
        if flipped == cardViews.count {
            for card in cardViews {
                card.isUserInteractionEnabled = false
            }
        } else {
            for card in cardViews {
                card.isUserInteractionEnabled = true
            }
        }
    }
// MARK: Делаем кнопку новой игры
    
    lazy var startButtonView = getStartButtonView()
    
    private func getStartButtonView() -> UIButton {
        // 1 создаем кнопку
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        // 2
        // изменяем положение кнопки
        button.center.x = view.center.x
        // получаем доступ к текущему окну
        let window = UIApplication.shared.windows[0]
        // определяем отступ сверху до границ safe area
        let topPadding = window.safeAreaInsets.top
        // устанавливаем координаты У кнопки
        button.frame.origin.y = topPadding
        // 3
        // настраиваем внешний вид кнопки
        button.setTitle("Начать игру", for: .normal)
        button.setTitleColor(.black, for: .normal)
        // устанавливаем цвет текста для нажатого состояния
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        
        // 4
        // подключаем обработчик нажатия на кнопку
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc func startGame(_ sender: UIButton) {
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
    }
    
// MARK: добавляем игровое поле
    lazy var boardGameView = getBoardGameView()
    
    private func getBoardGameView() -> UIView {
        let margin: CGFloat = 10
        
        let boardView = UIView()
        // координата X
        boardView.frame.origin.x = margin
        // координата Y
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
        
        // рассчитываем ширину
        boardView.frame.size.width = UIScreen.main.bounds.width - margin * 2
        // рассчитываем высоту с учетом нижнего отступа
        let bottomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        
        // изменяем стиль игрового поля
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        boardView.tag = 1000
        
        return boardView
    }
    
// MARK: генерация массива карточек на основе данных модели
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
        
    }
    
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        // хранилище для представлений карточек
        var cardViews = [UIView]()
        // фабрика карточек
        let cardViewFactory = CardViewFactory()
        // перебираем массив карточек в модели
        for (index, modelCard) in modelData.enumerated() {
            // добавляем первый экземпляр карты
            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            
            // добавляем второй экземпляр карты
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        // добавляем всем картам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = { [self] flippedCard in
                // переносим карточку вверх иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)
                
                // добавляем или удаляем карточку
                if flippedCard.isFlipped {
                    self.flippedCards.append(flippedCard)
                } else {
                    if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                        self.flippedCards.remove(at: cardIndex)
                    }
                }
                
                // если перевернуто 2 карточки
                if self.flippedCards.count == 2 {
                    // получаем карточки из данных модели
                    let firstCard = game.cards[self.flippedCards.first!.tag]
                    let secondCard = game.cards[self.flippedCards.last!.tag]
                    
                    // если карточки одинаковые
                    if game.checkCards(firstCard, secondCard) {
                        // сперва анимированно скрываем их
                        UIView.animate(withDuration: 0.3, animations: {
                            self.flippedCards.first!.layer.opacity = 0
                            self.flippedCards.last!.layer.opacity = 0
                            // после чего удаляем из иерархии
                        }, completion: { _ in
                            self.flippedCards.first!.removeFromSuperview()
                            self.flippedCards.last!.removeFromSuperview()
                            self.flippedCards = []
                        })
                        // в ином случае
                    } else {
                        // переворачиваем карточки рубашкой вверх
                        for card in self.flippedCards {
                            (card as! FlippableView).flip()
                        }
                    }
                }
            }
        }
        return cardViews
    }
    
    var cardViews = [UIView]()
    
    private func placeCardsOnBoard(_ cards: [UIView]) {
        // удаляем все имеющиесся на игровом поле карточки
        for card in cardViews {
            card.removeFromSuperview()
        }
        cardViews = cards
        // перебираем карточки
        for card in cardViews {
            // для каждой карточки генерируем случайные координаты
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
            // размещаем карточку на игровом поле
            boardGameView.addSubview(card)
        }
    }
// MARK: Обработчик провреик карт на свопадение
    private var flippedCards = [UIView]()
    
    
}

