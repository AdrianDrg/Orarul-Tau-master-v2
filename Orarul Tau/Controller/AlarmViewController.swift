//
//  AlarmViewController.swift
//  Orarul Tau
//
//  Created by Draghici Adrian on 18/04/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class AlarmViewController: UIViewController,UIPickerViewDelegate,UITextFieldDelegate, UNUserNotificationCenterDelegate{
    @IBOutlet weak var hourWasPicked: UIDatePicker!
    @IBOutlet weak var messageTextField: UITextField!
    
    var date24 = ""
    var hourString = ""
    var minString = ""
    var messageInserted = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        messageTextField.delegate = self
        UNUserNotificationCenter.current().delegate = self
    }
    
    /*===Notification set-up ====*/
    func sendNotofication(){
        let notification = UNMutableNotificationContent()
        notification.title = "Nu uita de evenimentul important de astazi!"
        notification.subtitle = messageInserted
        print(notification.subtitle)
        notification.categoryIdentifier = "User insert a message and a time"
        notification.sound = UNNotificationSound.default()
        
        var dateComp = DateComponents()
        dateComp.hour = Int(hourString)
        print(dateComp.hour as Any)
        dateComp.minute = Int(minString)
        print(dateComp.minute as Any)
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
        let notificationRequestIdentifier = "Orarul tau"
        let request = UNNotificationRequest(identifier: notificationRequestIdentifier, content: notification, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error as Any)
        }
    }
    
    /*===What user can do when notification is on screen====*/
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    }
    
    /*===Done button on keyboard====*/
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AlarmViewController.doneButtonAction))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.messageTextField.inputAccessoryView = doneToolbar
    }
    
    /*===Done button is pressed====*/
    @objc func doneButtonAction() {
        self.messageTextField.resignFirstResponder()
    }
    
    /*===End text adding====*/
    @IBAction func textEditEnd(_ sender: Any) {
        messageInserted = messageTextField.text!
    }
    
    /*===When the hour is selected====*/
    @IBAction func hourSelected(_ sender: UIDatePicker) {
        takeSelectedHour()
    }
    
    /*===Take selected hour, convert and format it====*/
    func takeSelectedHour(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.dateFormat = "h:mm a"
        let strDate = dateFormatter.string(from: hourWasPicked.date)
        let date = dateFormatter.date(from: strDate)
        dateFormatter.dateFormat = "HH:mm"
        date24 = dateFormatter.string(from: date!)
        let str = date24
         hourString = String(str.prefix(2))
         minString = String(str.suffix(2))
        print(hourString, minString)
    }

    /*===The add button is pressed====*/
    @IBAction func adaugaButtonPressed(_ sender: UIButton) {
        sendNotofication()
    }
}
