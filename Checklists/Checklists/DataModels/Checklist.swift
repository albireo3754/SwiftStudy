//
//  Checklist.swift
//  Checklists
//
//  Created by 윤상진 on 2021/07/12.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    init(name: String) {
        self.name = name
    }
    
    func countUncheckedItems() -> Int {
        let count = items.reduce(0) {
            cnt, item in cnt + (item.checked ? 0 : 1)
        }
        return count
    }
}
