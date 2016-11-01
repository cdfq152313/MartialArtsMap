//
//  MyNoti.swift
//  MartialArtsMap
//
//  Created by denny on 11/1/16.
//  Copyright © 2016 denny. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class MyNotiManager{
    private static var instance:MyNotiManager?
    private var notiArray = [NotiItem]()
    private let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("mynoti.json")
    
    private init(){
        
    }
    
    static func getInstance()->MyNotiManager{
        if MyNotiManager.instance == nil{
            MyNotiManager.instance = MyNotiManager()
        }
        return MyNotiManager.instance!
    }
    
    func addNoti(notiItem:NotiItem){
        if #available(iOS 10.0, *){
            pushNotiIOS10(notiItem)
        }
        else{
            pushNotiIOS9(notiItem)
        }
        notiArray.append(notiItem)
    }
    
    func pushNotiIOS10(_ notiItem:NotiItem){
        if #available(iOS 10.0, *){
            let content = UNMutableNotificationContent()
            content.title = notiItem.event
            content.body = notiItem.detail
            content.badge = 1
            content.sound = UNNotificationSound.default()
            
            let components = NSCalendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notiItem.date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "notification1", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    func pushNotiIOS9(_ notiItem:NotiItem){
        let localNoti = UILocalNotification()
        localNoti.fireDate = notiItem.date
        localNoti.alertBody = notiItem.event
        localNoti.soundName = UILocalNotificationDefaultSoundName
        localNoti.applicationIconBadgeNumber = 1
        UIApplication.shared.scheduleLocalNotification(localNoti)
    }
    
    func getArray()->[NotiItem]{
        return notiArray
    }
    
    func count()->Int{
        return notiArray.count
    }
    func getItem(row:Int)->NotiItem{
        return notiArray[row]
    }
    
    func delete(row:Int){
        notiArray.remove(at: row)
    }
}

class NotiItem{
    let date:Date
    let event:String
    let detail:String
    init (date:Date, event:String, detail:String){
        self.date = date
        self.event = event
        self.detail = detail
    }
}
