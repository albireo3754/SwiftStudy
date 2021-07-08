//
//  ViewController.swift
//  Checklists
//
//  Created by 윤상진 on 2021/07/07.
//

import UIKit

class ChecklistViewController: UITableViewController {
    // MARK: - Table View Data Source
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...5 {
            items.append(ChecklistItem())
            items[i].text = "\(i)"
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
