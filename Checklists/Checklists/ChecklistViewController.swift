//
//  ViewController.swift
//  Checklists
//
//  Created by 윤상진 on 2021/07/07.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemTableViewControllerDelegate {
    func addItemTableViewControllerDidCancel(_ controller: AddItemTableViewController) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func addItemTableViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table View Data Source
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...5 {
            items.append(ChecklistItem())
            items[i].text = "\(i)"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemTableViewController
            controller.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let label = cell.viewWithTag(30) as! UILabel
        let item = items[indexPath.row]
        label.text = item.text
        item.checked.toggle()
        configureCheckmark(for: cell, at: indexPath)
        return cell
    }
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        let item = items[indexPath.row]
        if item.checked {
//            cell.accessoryType = UITableViewCell.AccessoryType.checkmark 아래와 같음
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
}
