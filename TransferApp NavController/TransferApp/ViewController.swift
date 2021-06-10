//
//  ViewController.swift
//  TransferApp
//
//  Created by Илья Москалев on 10.06.2021.
//

import UIKit

protocol UpdatableDataController {
    var updatedData: String { get set }
}

class ViewController: UIViewController, UpdatableDataController {
    var updatedData: String = ""
    

    @IBOutlet var dataLabel: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }

    private func updateLabel(withText text: String) {
        dataLabel.text = updatedData
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        
        editScreen.updatingData = dataLabel.text ?? ""
        
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
    }
    
}

