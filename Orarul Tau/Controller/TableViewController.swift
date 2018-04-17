//
//  TableViewController.swift
//  Orarul Tau
//
//  Created by Draghici Adrian on 16/04/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import UIKit

struct cellData {
    var oppened = Bool()
    var title = String ()
    var sectionData = [String]()
    var type = Int()
}

class TableViewController: UITableViewController {
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [cellData(oppened: false, title: "Luni", sectionData: ["Row1", "Row2", "Row3"], type: 1),
                         cellData(oppened: false, title: "Marti", sectionData: ["Row1", "Row2", "Row3"], type: 0),
                         cellData(oppened: false, title: "Miercuri", sectionData: ["Row1", "Row2", "Row3"], type: 1),
                         cellData(oppened: false, title: "Joi", sectionData: ["Row1", "Row2", "Row3"], type: 0),
                         cellData(oppened: false, title: "Vineri", sectionData: ["Row1", "Row2", "Row3"], type: 0)]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].oppened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "cellHeader") as! HeaderTableViewCell
            headerCell.dayText.text = tableViewData[indexPath.section].title
            
            if tableViewData[indexPath.section].oppened == true {
                headerCell.backgroundColor = UIColor(red: 8/250.0, green: 50/250.0, blue: 97/250.0, alpha: 1)
                headerCell.dayText.textColor = UIColor.white
                headerCell.intervalOrar.textColor = UIColor.white
            } else {
                headerCell.backgroundColor = UIColor.white
                headerCell.dayText.textColor = UIColor(red: 8/250.0, green: 50/250.0, blue: 97/250.0, alpha: 1)
                headerCell.intervalOrar.textColor = UIColor(red: 8/250.0, green: 50/250.0, blue: 97/250.0, alpha: 1)


            }
            return headerCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.infoLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            
            if tableViewData[indexPath.row].type == 0 {
                cell.infoImage.image = #imageLiteral(resourceName: "Curs-100")
            } else {
                cell.infoImage.image = #imageLiteral(resourceName: "Seminar-100")
            }
            cell.intervalOrar.text = "DEMO"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].oppened == true {
                tableViewData[indexPath.section].oppened = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
            } else {
                tableViewData[indexPath.section].oppened = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
                
            }
        }
    }
}
