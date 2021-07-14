//
//  DataModel.swift
//  Checklists
//
//  Created by 윤상진 on 2021/07/12.
//

import Foundation

class DataModel {
    class func nextChecklistID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        return itemID
    }
    var lists = [Checklist]()
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistItem")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistItem")
        }
        
    }
    init() {
        print(documentsDirectory())
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        sortChecklist()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
        
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    func registerDefaults() {
        let dictionary = ["ChecklistsIndex" : -1, "FirstTime" : true] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "Example List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
        }
    }
    
    func sortChecklist() {
        lists.sort() {
//            $0.name.localizedCompare($1.name) == .orderedAscending
            $0.name < $1.name
        }
    }
}
