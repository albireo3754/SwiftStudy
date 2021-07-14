//
//  ChecklistItem.swift
//  Checklists
//
//  Created by 윤상진 on 2021/07/08.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    deinit {
        removeNotification()
    }
    
    func scheduleNotification() {
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder: "
            content.body = text
            content.sound = .default
            
            let calender = Calendar(identifier: .gregorian)
            let components = calender.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
}
