//
//  SecondViewController.swift
//  Study_project1
//
//  Created by Илья Москалев on 03.06.2021.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func hideCurrentScene(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
