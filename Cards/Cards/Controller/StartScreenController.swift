//
//  StartScreenController.swift
//  Cards
//
//  Created by Илья Москалев on 25.06.2021.
//

import UIKit

class StartScreenController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startCardsGameButton)
        view.addSubview(SettingsButton)
        self.navigationController?.isNavigationBarHidden = true
        
        title = "Стартовое меню"
    }

    lazy var startCardsGameButton = getStartCardsGameButton()
    
    private func getStartCardsGameButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        
        button.center.x = view.center.x
        button.center.y = view.center.y - 50
        
        button.setTitle("Карты", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        button.addTarget(self, action: #selector(openCardsGame), for: .touchUpInside)
        
        return button
    }
    
    @objc func openCardsGame() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Cards") as? BoardGameController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    lazy var SettingsButton = getSettingsButton()
    
    private func getSettingsButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        
        button.center.x = view.center.x
        button.center.y = view.center.y + 50
        
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        
        return button
    }
    
    @objc func openSettings() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Settings") as? SettingsController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
