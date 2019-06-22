//
//  RecordTableViewController.swift
//  Note
//
//  Created by user21 on 2019/6/13.
//  Copyright © 2019 user21. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {

    
    var records = [Record]()
    
    @IBAction func goBackToRecordTable(segue: UIStoryboardSegue){
        let controller = segue.source as? EditRecordTableViewController
        
        if let record = controller?.record{
            if let row = tableView.indexPathForSelectedRow?.row{
                records[row] = record
            }else{
                records.insert(record, at: 0)
            }
            
            Record.saveToFile(records: records)
            
            tableView.reloadData()
        }
    }
    
    // when the view shows up , load data from File and refresh the tableView
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let records = Record.readRecordFromFile(){
            self.records = records
        }
        tableView.reloadData()
    }
    
    // when the view is loaded , load data from File
    override func viewDidLoad() {
        super.viewDidLoad()

        if let records = Record.readRecordFromFile(){
            self.records = records
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // set the number of row as the same number as records count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
        
        let record = records[indexPath.row]
        cell.dateLabel.text = "\(record.year)\\\(record.month)\\\(record.day)"
        cell.typeLabel.text = record.type
        cell.amountLabel.text = "$" + String(record.amount)
        if(indexPath.row % 3 == 1){
            cell.backgroundColor = UIColor(red:1.00, green:0.93, blue:0.86, alpha:1.0)
        }else if(indexPath.row % 3 == 2){
            cell.backgroundColor = UIColor(red:0.93,green:0.86,blue:1.00,alpha :1.0)
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        records.remove(at: indexPath.row)
        Record.saveToFile(records: records)
        tableView.reloadData()
        
    }
    
}
