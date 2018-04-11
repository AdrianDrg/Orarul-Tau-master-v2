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
        
        /*===Text fields for select Unversiy====*/
        @IBOutlet weak var uniEdit: UITextField!
        @IBOutlet weak var facEdit: UITextField!
        @IBOutlet weak var groupEdit: UITextField!
        
        /*===Define the call parrameters and global variabels====*/
        var indexValue = 0
        var paramIndex = 0
        var selectedGroup = ""
        var grupeArray = [Int]()
        var sGrupeArray = [String]()
        var collegeIS : College?
        var grupeArrayForRel = [Grupe]()
        var saliArrayForRel = [Sali]()
        var utime : String = ""
        let fac = ["CSIE"]
        let universitati = ["Academia de Studii Economice din Bucuresti"]
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let accesURL = "http://www.sisc.ro/orar/api/gate.php"
        let collegesParameters : [String : String] = ["action" : "get_colleges", "client" : "Android", "version" : "1.519"]
        let updateParameters : [String : String] = ["college" : "csie", "action" : "get_updates", "client" : "Android", "version" : "1.519"]
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
                    if param == self.collegesParameters {
                        self.CollegeJsonDataParsing(json: data)
                        print("College json parsing!")
                    }else if param == self.groupParameters {
                        self.GroupJsonDataParsing(json: data)
                        print("Group json parsing!")
                    }else if param == self.materiiParameters {
                        self.MateriiJsonDataParsing(json: data)
                        print("Materii json parsing!")
                    }else if param == self.profesoriParameters {
                        self.ProfesoriJsonDataParsing(json: data)
                        print("Profesori json parsing!")
                    } else if param == self.saliParameters {
                        self.SaliJsonDataParsing(json: data)
                        print("Sali json parsing!")
                    } else if param == self.oreParameters {
                        self.OreJsonDataParsing(json: data)
                        self.getDataForGrupe()
                    } else {
                        print("THIS ARE ALL PARAMS")
                    }
                    } else {
                        print("There was an error \(String(describing: response.result.error))")
                    }
                }
            }
        
            /*===Check if the College server uTime is equal with Stored uTime====*/
            func TakeCollegeUtime(){
                let request : NSFetchRequest<College> = College.fetchRequest()
                do {
                    let dataInfo = try context.fetch(request)
                    for data in dataInfo {
                        if data.uTime != nil {
                            utime = data.uTime!
                    }
                }
            } catch {
                print("Error fathing data from context \(error)")
            }
        }
        
        /*===Check if the Group server uTime is equal with Stored uTime====*/
        func TakeGroupUtime(){
            let request : NSFetchRequest<Grupe> = Grupe.fetchRequest()
            do {
                let dataInfo = try context.fetch(request)
                for data in dataInfo {
                    if data.uTime != nil {
                        utime = data.uTime!
                    }
                }
            } catch {
                print("Error fathing data from context \(error)")
            }
        }
        
        /*===Check if the Materii server uTime is equal with Stored uTime====*/
        func TakeMateriiUtime(){
            let request : NSFetchRequest<Materii> = Materii.fetchRequest()
            do {
                let dataInfo = try context.fetch(request)
                for data in dataInfo {
                    if data.uTime != nil {
                        utime = data.uTime!
                    }
                }
            } catch {
                print("Error fathing data from context \(error)")
            }
        }
        
        /*===Check if the Profesori server uTime is equal with Stored uTime====*/
        func TakeProfesoriUtime(){
            let request : NSFetchRequest<Profesori> = Profesori.fetchRequest()
            do {
                let dataInfo = try context.fetch(request)
                for data in dataInfo {
                    if (data as AnyObject).uTime != nil {
                        utime = (data as AnyObject).uTime!!
                    }
                }
            } catch {
                print("Error fathing data from context \(error)")
            }
        }
        
        /*===Check if Sali server uTime is equal with Stored uTime====*/
        func TakeSaliUtime(){
            let request : NSFetchRequest<Sali> = Sali.fetchRequest()
            do {
                let dataInfo = try context.fetch(request)
                for data in dataInfo {
                    if data.uTime != nil {
                        utime = data.uTime!
                    }
                }
            } catch {
                print("Error fathing data from context \(error)")
            }
        }
        
        /*===Check if Ore server uTime is equal with Stored uTime====*/
        func TakeOreUtime(){
            let request : NSFetchRequest<Ore> = Ore.fetchRequest()
            do {
                let dataInfo = try context.fetch(request)
                for data in dataInfo {
                    if data.uTime != nil {
                        utime = data.uTime!
                    }
                }
            } catch {
                print("Error fathing data from context \(error)")
            }
        }
        
        func DeleteData(entity: String){
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do {
                try context.execute(deleteRequest)
                SaveData()
            } catch {
                print ("There was an error")
            }
        }
        /*===Parsing the College JSON====*/
        func CollegeJsonDataParsing(json : JSON) {
            TakeCollegeUtime()
            if utime != String(describing: json["response"]["colleges"][0]["utime"]) {
                DeleteData(entity: "College")
                let setCollege = College(context: context)
               setCollege.title = String(describing: json["response"]["colleges"][0]["title"])
               setCollege.uTime = String(describing: json["response"]["colleges"][0]["utime"])
                setCollege.college = String(describing: json["response"]["colleges"][0]["college"])
                SaveData()
                getData(URL: accesURL, param: groupParameters)
            } else {
                print("We already have data!")
                getData(URL: accesURL, param: groupParameters)
            }
        }
        
        /*===Parsing the Group JSON====*/
        func GroupJsonDataParsing(json : JSON) {
            TakeGroupUtime()
            if utime != String(describing: json["response"]["grupe"][0]["utime"]) {
                DeleteData(entity: "Grupe")
                let fetchRequest = NSFetchRequest<College>(entityName: "College")
                do {
                    let fetchedResults = try context.fetch(fetchRequest)
                        collegeIS = fetchedResults[0]
                } catch let error as NSError {
                    // something went wrong, print the error.
                    print(error.description)
                }
                json["response"]["grupe"].forEach{
                    let setGrupe = Grupe(context: self.context)
                    setGrupe.an = String(describing: $1["an"])
                    setGrupe.id = String(describing: $1["id"])
                    setGrupe.serie =  String(describing: $1["serie"])
                    setGrupe.title = String(describing: $1["title"])
                    setGrupe.uTime = String(describing: $1["utime"])
                    setGrupe.bellongsToColegiu = collegeIS
                }
                SaveData()
                getData(URL: accesURL, param: materiiParameters)
            } else {
                getData(URL: accesURL, param: materiiParameters)
            }
        }
        
        /*===Parsing the Materii JSON====*/
        func MateriiJsonDataParsing(json : JSON){
            TakeMateriiUtime()
            if utime != String(describing: json["response"]["materii"][0]["utime"]) {
                DeleteData(entity: "Materii")
               json["response"]["materii"].forEach{
                    let setMaterii = Materii(context: context)
                    setMaterii.an = String(describing: $1["an"])
                    setMaterii.credite = String(describing: $1["credite"])
                    setMaterii.id = String(describing: $1["id"])
                    setMaterii.specializare = String(describing: $1["specializare"])
                    setMaterii.title = String(describing: $1["title"])
                    setMaterii.uTime = String(describing: $1["utime"])
                }
                SaveData()
                getData(URL: accesURL, param: profesoriParameters)
            } else {
                getData(URL: accesURL, param: profesoriParameters)
            }
        }
        
        /*===Parsing the Profesori JSON====*/
        func ProfesoriJsonDataParsing(json: JSON) {
            TakeProfesoriUtime()
            if utime != String(describing: json["response"]["profesori"][0]["utime"]) {
               DeleteData(entity: "Profesori")
                json["response"]["profesori"].forEach {
                    let setProfesori = Profesori(context: context)
                    setProfesori.id = String(describing: $1["id"])
                    setProfesori.title = String(describing: $1["title"])
                    setProfesori.uTime = String(describing: $1["utime"])
                }
                SaveData()
                getData(URL: accesURL, param: saliParameters)
            } else {
                getData(URL: accesURL, param: saliParameters)
            }
        }
        
        /*===Parsing the Sali JSON====*/
        func SaliJsonDataParsing(json : JSON) {
            TakeSaliUtime()
            if utime != String(describing: json["response"]["sali"][1]["utime"]) {
                DeleteData(entity: "Sali")
                json["response"]["sali"].forEach{
                    let setSali = Sali(context: context)
                    setSali.id = String(describing: $1["id"])
                    setSali.title = String(describing: $1["title"])
                    setSali.uTime = String(describing: $1["utime"])
                }
                SaveData()
                getData(URL: accesURL, param: oreParameters)
            } else {
                getData(URL: accesURL, param: oreParameters)
            }
        }
       
        /*===Parsing the Ore JSON====*/
        func OreJsonDataParsing(json : JSON){
            TakeOreUtime()
            if utime != String(describing: json["response"]["ore"][0]["utime"]) {
                DeleteData(entity: "Ore")
                let fetchRequest = NSFetchRequest<Grupe>(entityName: "Grupe")
                do {
                    let fetchedResults = try context.fetch(fetchRequest)
                    for result in 0..<fetchedResults.count{
                        grupeArrayForRel.append(fetchedResults[result])
                    }
                } catch let error as NSError {
                    // something went wrong, print the error.
                    print(error.description)
                }
                let saliFetchRequest = NSFetchRequest<Sali>(entityName: "Sali")
                do {
                    let saliFetchedResults = try context.fetch(saliFetchRequest)
                    for result in 0..<saliFetchedResults.count{
                        saliArrayForRel.append(saliFetchedResults[result])
                    }
                } catch let error as NSError {
                    // something went wrong, print the error.
                    print(error.description)
                }
                json["response"]["ore"].forEach {
                    let setOre = Ore(context: context)
                    setOre.grupa_ID = String(describing: $1["grupa_id"])
                    setOre.id = String(describing: $1["id"])
                    setOre.materie_ID = String(describing: $1["materie_id"])
                    setOre.profesor_ID = String(describing: $1["profesor_id"])
                    setOre.sala_ID = String(describing: $1["sala_id"])
                    setOre.uTime = String(describing: $1["utime"])
                    setOre.zi_index = String(describing: $1["zi_index"])
                    setOre.ora_index = String (describing: $1["ora_index"])
                    setOre.type = String (describing: $1["type"])
                    setOre.categ = String (describing: $1["categ"])
                    for size in 0..<grupeArrayForRel.count{
                        if grupeArrayForRel[size].id == setOre.grupa_ID{
                            setOre.belongsToGrupe = grupeArrayForRel[size]
                        }
                    }
                    for sali in 0..<saliArrayForRel.count{
                        if saliArrayForRel[sali].id == setOre.sala_ID{
                            setOre.hasSala = saliArrayForRel[sali]
                        }
                    }
                }
                SaveData()
               print("End of parsing data!")
            } else {
              print("End of parsing data!")
            }
        }
        
        /*===Save the Context====*/
        func SaveData(){
            do {
                try context.save()
            } catch {
                print("There was an error when saving the data \(error)")
            }
        }
       
        /*===Fetch data for group pickerview====*/
        func getDataForGrupe() {
            let fetchRequest = NSFetchRequest<Grupe>(entityName: "Grupe")
            do {
                let fetchedResults = try context.fetch(fetchRequest)
                fetchedResults.forEach {
                    if $0.title != nil {
                        grupeArray.append(Int($0.title!)!)
                    }
                }
                grupeArray = grupeArray.sorted()
                sGrupeArray = grupeArray.map{
                    String($0)
                }
            } catch let error as NSError {
                print(error.description)
            }
        }
        
        /*===What happens when "Vezi orarul" button is pressed====*/
        @IBAction func veziOrarulPressed(_ sender: UIButton) {
     
        
            
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
            picker.pickerData = fac
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
            picker.pickerData = sGrupeArray
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
        
        /*===What is selected in PickerView====*/
        func pickerSelector(_ selector: SBPickerSelector, selectedValues values: [String], atIndexes idxs: [NSNumber])
        {
            if indexValue == 1 {
                uniEdit.text = values[0]
            } else if indexValue == 2 {
                facEdit.text = values[0]
            } else if indexValue == 3 {
                groupEdit.text = values[0]
                selectedGroup = String(values[0])
            }
        }
        /*===Prepare the data to be sent on the next screen====*/

    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        //let destinationVC = segue.destination as! OrarViewController
    //
    //    }
        
        
    }

