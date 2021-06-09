//
//  ViewController.swift
//  7.1 table
//
//  Created by Илья Москалев on 09.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var storage: ContactStorageProtocol!
    
    private var contacts: [ContactProtocol]  = [] {
        didSet {
            contacts.sort { $0.title < $1.title }
            storage.save(contacts: contacts)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        storage = ContactStorage()
        loadContacts()
    }
    
    private func loadContacts() {
        contacts = storage.load()
        
    }
    
    @IBAction func showNewContactAlert() {
        let ac = UIAlertController(title: "Создайте новый конакт", message: "Введите имя и телефон", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Имя"
        }
        ac.addTextField { textField in
            textField.placeholder = "Номер телефона"
        }
        let createButton = UIAlertAction(title: "Создать", style: .default) { _ in
            guard let contactName = ac.textFields?[0].text,
                  let contactPhone = ac.textFields?[1].text else {
                return
            }
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        ac.addAction(cancelButton)
        ac.addAction(createButton)
        
        self.present(ac, animated: true)
    }
    // MARK: UserDefaults
    
}

// MARK: Extensions
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Определяем доступные действия для строки \(indexPath.row)")
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
}

