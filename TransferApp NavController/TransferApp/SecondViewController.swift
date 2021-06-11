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

    @IBAction func saveData(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var editScreen = storyboard.instantiateViewController(withIdentifier: "ViewController") as! UpdatableDataController
            
            editScreen.updatedData = dataTextField.text ?? ""
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
        
    }
    
    // MARK: Unwind segue
    // Передача данных от Б к А по нажатию на Unwind segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else { return }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    
    // MARK: Delagations
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        // получаем обновленные данные
        let updatedData = dataTextField.text ?? ""
        // вызываем метод делегата
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        // возвращаемся на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Передача с помощью замыкания
    var completionHandler: ((String) -> Void)?
    
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        // получаем обновленные данные
        let updatedData = dataTextField.text ?? ""
        // Вызываем замыкание
        completionHandler?(updatedData)
        // Возвращаем на предыдущий экран
        navigationController?.popViewController(animated: true)
    }
}
