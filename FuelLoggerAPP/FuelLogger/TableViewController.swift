//
//  TableTableViewController.swift
//  App
//
//  Created by Admin on 09.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData

class TableTableViewController: UITableViewController {
    
    var managedStops: [NSManagedObject] = []
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        tableView.rowHeight = 60
        
        managedStops = getData()
        if UserDefaults.standard.integer(forKey: "sortItems") == 1 {
            sortByState()
        }
        tableView.reloadData()
        
    }
    
    // adds stop to the coredata model
    func addStop(location: String, time: String, gallons: Float, extra: String) -> NSManagedObject {
        let stop = NSEntityDescription.insertNewObject(forEntityName: "StopData", into: self.managedObjectContext)
        stop.setValue(location, forKey: "location")
        stop.setValue(time, forKey: "time")
        stop.setValue(gallons, forKey: "gallons")
        stop.setValue(extra, forKey: "extra")
        appDelegate.saveContext()
        return stop
    }
    
    // retreives data stored in the coredata
    func getData() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StopData")
        var stops: [NSManagedObject] = []
        do {
            stops = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("stopData error: \(error)")
        }
        return stops
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return managedStops.count
    }

    // initializes tableview cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell", for: indexPath) as! StopCell

        // Configure the cell...
        let indexRow = indexPath.row
        
        // this is to reverse the list
        let stop = managedStops[managedStops.count-indexRow-1]
        
        let loc = stop.value(forKey: "location") ?? ""
        let time = stop.value(forKey: "time") ?? ""
        let gal = stop.value(forKey: "gallons") ?? ""
        let portion = String(describing: loc) + "\t\tDate: " + String(describing: time) + "\t\tGal: "
        cell.stopInfoLabel.text = String(describing: portion) + String(describing: gal)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let indexRow = indexPath.row
            
            // need to do this becuase list is in fact reversed
            // flips the row index used to be oppisite
            let row = managedStops.count-indexRow-1
            
            let stop = managedStops[row]
            removeStop(stop)
            managedStops.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    func removeStop(_ stop: NSManagedObject) {
        managedObjectContext.delete(stop)
        appDelegate.saveContext()
    }
    func deleteAll(){
        for stop in managedStops {
            removeStop(stop)
        }
        managedStops = []
        tableView.reloadData()
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSettings") {
            let settingsVC = segue.destination as! Settings
            settingsVC.managedStops = managedStops
        }
    }
    
    @IBAction func unwindFromSecondView (sender: UIStoryboardSegue) {
    
    let secondVC = sender.source as! ViewController
        if let stopData = secondVC.stop {
            let myStop = addStop(location: stopData.location, time: stopData.time, gallons: stopData.gallons, extra: stopData.extra)
            managedStops.append(myStop)
            if UserDefaults.standard.integer(forKey: "sortItems") == 1 {
                sortByState()
            }
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindFromThirdView (sender: UIStoryboardSegue) {
    
    let thirdVC = sender.source as! Settings
        if let clear = thirdVC.delete {
            // more stuff to delete data here
            if clear {
                deleteAll()
            }
            if !clear {
                switch(UserDefaults.standard.integer(forKey: "sortItems")){
                case 0:  managedStops = getData()
                case 1:  sortByState();
                default:
                    break;
                }
                tableView.reloadData()
            }
        }
    }
    
    func sortByState(){
        // sorts the managedStops array by state (a-z)
        let sorted = managedStops.sorted {"\($0.value(forKey: "location"))" > "\($1.value(forKey: "location"))"}
        managedStops = sorted
        print("sortingByState")
    }
}
