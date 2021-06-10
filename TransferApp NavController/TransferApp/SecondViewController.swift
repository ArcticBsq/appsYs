//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Илья Москалев on 10.06.2021.
//

import UIKit

protocol UpdatingDataController: class {
    var updatingData: String { get set }
}

class SecondViewController: UIViewController, UpdatingDataController {

    @IBOutlet var dataTextField: UITextField!
    
    var updatingData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }

    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editScreen = storyboard.instantiateViewController(withIdentifier: "ViewController") as! UpdatableDataController
        
        editScreen.updatedData = dataTextField.text ?? ""
    }
}
