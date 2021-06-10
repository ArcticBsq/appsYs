//
//  ViewController.swift
//  NavigationApp
//
//  Created by Илья Москалев on 10.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    let storyBoardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    @IBAction func toGreenScene(_ sender: UIButton) {
        let vc = storyBoardInstance.instantiateViewController(identifier: "green")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toYellowController(_ sender: UIButton) {
        let vc = storyBoardInstance.instantiateViewController(identifier: "yellow")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toRootScene(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func toPreviousScene(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true
        )
    }
}

