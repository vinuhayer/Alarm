//
//  AlarmController.swift
//  Alarm
//
//  Created by Appinventiv on 12/04/20.
//  Copyright © 2020 Appinventiv. All rights reserved.
//

import Foundation
import UserNotifications

typealias JSONDictionary = [String : Any]

class AlarmController : NSObject {
    
    enum AlarmType {
        case expired
        case future
    }
    
    //MARK:- VARIABLES
    //=====================
    static let sharedAlarm = AlarmController()
    private var alarms : [AlarmModel] = []
    
    //MARK:- FUNCTIONS
    //=======================
    /// Set Alarm
    func scheduleAlarm(dateStr: String , time: String , title: String, subject: String) {
        
        var arrNotIds : [String] = []
       
        let dateString = dateStr+" "+time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: dateString) else {
            print("Date is not in the correct format")
            return
        }
    
        var dateInfo = DateComponents()
        dateInfo.hour = date.hour
        dateInfo.minute = date.minute
        dateInfo.timeZone = .current
        let alarmID = UUID().uuidString
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = subject
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = alarmID
        content.userInfo = ["AlarmID": alarmID]
        arrNotIds.append(alarmID)
        
        let request = UNNotificationRequest(identifier: alarmID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            
            if let error = error {
                print("Alarm error: \(error)")
            }
        }
        
        // Saving alarms in UserDefault
        let alarm = AlarmModel.init(date: dateStr, time: time, id: alarmID, title: title, subject: subject)
        
        var alarms : [JSONDictionary]
        if let actual = UserDefaults.standard.array(forKey: "alarms") as? [JSONDictionary] {
            alarms = actual
        } else {
            alarms = [JSONDictionary]()
        }
        alarms.insert(alarm.getDict(), at: 0)
        UserDefaults.standard.set(alarms, forKey: "alarms")
    }
    
    func fetchAlarms(type: AlarmType) -> [AlarmModel] {
        
        switch type {
        case .future:
            
            if let alarms = UserDefaults.standard.array(forKey: "alarms") as? [JSONDictionary] {
                
                let models = alarms.map({AlarmModel.init(dict: $0)})
                let futureAlarms = models.filter({$0.formattedDate > Date()})
                return futureAlarms
            }
            
        case .expired:
        
            if let alarms = UserDefaults.standard.array(forKey: "alarms") as? [JSONDictionary] {
                
                let models = alarms.map({AlarmModel.init(dict: $0)})
                let futureAlarms = models.filter({$0.formattedDate < Date()})
                return futureAlarms
            }
        }
        return []
    }
}

// MARK:- ALARM MODEL
//=========================
struct AlarmModel {
    var date : String?
    var time : String?
    var id : String?
    
    var title: String?
    var subject: String?
    
    var formattedDate : Date {
        let dateString = (date ?? "")+" "+(time ?? "")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    func getDict() -> JSONDictionary {
        var dict : JSONDictionary = [:]
        dict["date"] = date
        dict["time"] = time
        dict["id"] = id
        dict["title"] = title
        dict["subject"] = subject
        return dict
    }
    
    init(dict: JSONDictionary) {
        date = dict["date"] as? String
        time = dict["time"] as? String
        id = dict["id"] as? String
        title = dict["title"] as? String
        subject = dict["subject"] as? String
    }
    
    init(date: String?, time: String?, id: String?, title: String?, subject: String?) {
        self.date = date
        self.time = time
        self.id = id
        self.title = title
        self.subject = subject
    }
}
