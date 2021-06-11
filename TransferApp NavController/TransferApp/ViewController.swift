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

class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
    
    
    var updatedData: String = "111"
    

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
    // MARK: Работа с Segue от А к Б
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toEditScreen":
            // обрабатываем переход
            prepareEditScreen(segue)
        default:
            break
        }
    }
    // Подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // Безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else { return }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    // MARK: Unwind segue
    // Пишется в том контроллере, куда нужн осуществить переход, делается в одну строку без заполнения
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) { }
    
    // Mark: Передача от Б к А с Delagation
    // Функция из протокола
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier:
        "SecondViewController") as! SecondViewController
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated:
        true)
    }
    
    // MARK: Передача с помощью Closure
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        // Получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        // Передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // Передаем необходимое замыкание
        editScreen.completionHandler = {[unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        // Открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
}

