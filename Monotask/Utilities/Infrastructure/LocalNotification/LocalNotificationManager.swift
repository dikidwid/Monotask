//
//  NotificationManager.swift
//  Monotask
//
//  Created by Theresia Angela Ayrin on 22/08/24.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
    
    static let shared = LocalNotificationManager()
    
    private init() { }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else if granted {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        }
    }
    
    func scheduleNotification(notificationTitle: String, notificationMessage: String, reminderTime: Date) {
        let content = UNMutableNotificationContent()
        content.title = notificationTitle
        content.body = notificationMessage

        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "local-notification-sound.caf"))
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: reminderTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification request: \(error.localizedDescription)")
            } else {
                print("Notification successfully scheduled for \(reminderTime).")
            }
        }
    }
}
