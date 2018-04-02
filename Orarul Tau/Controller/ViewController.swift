//
//  ViewController.swift
//  Orarul Tau
//
//  Created by Draghici Adrian on 13/03/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import UIKit
import SBPickerSelector
import Alamofire
import SwiftyJSON
import CoreData

class ViewController: UIViewController, SBPickerSelectorDelegate, UITextFieldDelegate{
    
    /*===Text fields for selecting the Unversiy====*/
    @IBOutlet weak var uniEdit: UITextField!
    @IBOutlet weak var facEdit: UITextField!
    @IBOutlet weak var groupEdit: UITextField!
    var indexValue : Int = 0
    var paramIndex : Int = 0
    
    let universitati = ["Academia de Studii Economice din Bucuresti"]
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let accesURL = "http://www.sisc.ro/orar/api/gate.php"
    let collegesParameters : [String : String] = ["action" : "get_colleges", "client" : "Android", "version" : "1.519"]
    let uptateParameters : [String : String] = ["college" : "csie", "action" : "get_updates", "client" : "Android", "version" : "1.519"]
    let groupParameters : [String : String] = ["college" : "csie", "action" : "get_grupe", "client" : "Android", "version" : "1.519"]
    let materiiParameters : [String : String] = ["college" : "csie", "action" : "get_materii", "client" : "Android", "version" : "1.519"]
    let profesoriParameters : [String : String] = ["college" : "csie", "action" : "get_profesori", "client" : "Android", "version" : "1.519"]
    let saliParameters : [String : String] = ["college" : "csie", "action" : "get_sali", "client" : "Android", "version" : "1.519"]
    let oreParameters : [String : String] = ["college" : "csie", "action" : "get_ore", "client" : "Android", "version" : "1.519"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        getData(URL: accesURL, param: collegesParameters)
    }
        /*===Making the HTTP POST request====*/
    func getData(URL: String, param: [String : String]){
        Alamofire.request(URL, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { response in
            if response.result.isSuccess {
                print("Succes. We got the data!")
                let data : JSON = JSON(response.result.value!)
                self.JsonDataParsing(json: data)
                print("This is the data:\n \(data)")
            } else {
                print("There was an error \(String(describing: response.result.error))")
            }
        }
    }
    
    /*===Parsing the JSON====*/
    func JsonDataParsing(json : JSON) {

        let setGroup = College(context: self.context)
        setGroup.titlu_facultate = String(describing: json["response"]["colleges"][0]["title"])
        setGroup.uTime = String(describing: json["response"]["colleges"][0]["utime"])

        
        let stringSize = json["response"]["colleges"][0]["grupe"].count
        print(stringSize)
        
        var i = 0
        while i < stringSize{
            let setGroup = College(context: self.context)
            setGroup.id = String(describing: json["response"]["colleges"][0]["grupe"][i]["id"])
            setGroup.title = String(describing: json["response"]["colleges"][0]["grupe"][i]["title"])
            
        i += 1
        }
        
        SaveData()
        
        
    }
    
    func SaveData(){

        
        do {
            try context.save()
        } catch {
            print("There was an error when saving the data \(error)")
        }
    }
    
    @IBAction func veziOrarulPressed(_ sender: UIButton) {
        
        //Need to add the selected data
        
    }
    
    @IBAction func editStarted(_ sender: Any) {
       
        uniEdit.endEditing(true)
        let picker: SBPickerSelector = SBPickerSelector()
        picker.pickerData = universitati //picker content
        picker.delegate = self
        picker.pickerType = SBPickerSelectorType.text
        picker.doneButtonTitle = "Done"
        picker.cancelButtonTitle = "Cancel"
        picker.cancelButton?.tintColor = UIColor.red
        picker.doneButton?.tintColor = UIColor(red: 8/255.0, green: 50/255.0, blue: 97/255.0, alpha: 1)
        picker.pickerType = SBPickerSelectorType.text
        picker.showPickerOver(self)
        
        let point: CGPoint = view.convert((sender as AnyObject).frame.origin, from: (sender as AnyObject).superview)
        var frame: CGRect = (sender as AnyObject).frame
        frame.origin = point
        indexValue = 1
    }
    
    @IBAction func facultateEditStarted(_ sender: Any) {
        facEdit.endEditing(true)
        
        let picker: SBPickerSelector = SBPickerSelector()
        //picker.pickerData = Date!
        picker.delegate = self
        picker.pickerType = SBPickerSelectorType.text
        picker.doneButtonTitle = "Done"
        picker.cancelButtonTitle = "Cancel"
        picker.cancelButton?.tintColor = UIColor.red
        picker.doneButton?.tintColor = UIColor(red: 8/255.0, green: 50/255.0, blue: 97/255.0, alpha: 1)
        picker.pickerType = SBPickerSelectorType.text
        picker.showPickerOver(self)
        
        let point: CGPoint = view.convert((sender as AnyObject).frame.origin, from: (sender as AnyObject).superview)
        var frame: CGRect = (sender as AnyObject).frame
        frame.origin = point
        indexValue = 2
    }
    
    @IBAction func groupEditStarted(_ sender: Any) {
        groupEdit.endEditing(true)
        
        let picker: SBPickerSelector = SBPickerSelector()
       // picker.pickerData = Date!
        picker.delegate = self
        picker.pickerType = SBPickerSelectorType.text
        picker.doneButtonTitle = "Done"
        picker.cancelButtonTitle = "Cancel"
        picker.cancelButton?.tintColor = UIColor.red
        picker.doneButton?.tintColor = UIColor(red: 8/255.0, green: 50/255.0, blue: 97/255.0, alpha: 1)
        picker.pickerType = SBPickerSelectorType.text
        picker.showPickerOver(self)
        
        let point: CGPoint = view.convert((sender as AnyObject).frame.origin, from: (sender as AnyObject).superview)
        var frame: CGRect = (sender as AnyObject).frame
        frame.origin = point
        indexValue = 3
        
    }
    func pickerSelector(_ selector: SBPickerSelector, selectedValues values: [String], atIndexes idxs: [NSNumber])
    {
        if indexValue == 1 {
            uniEdit.text = values[0]
        } else if indexValue == 2 {
            facEdit.text = values[0]
        } else if indexValue == 3 {
            groupEdit.text = values[0]
        }
    }
    
}



