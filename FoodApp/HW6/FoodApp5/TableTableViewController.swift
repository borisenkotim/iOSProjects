//
//  TableTableViewController.swift
//  FoodApp5
//
//  Created by Tim Borisenko
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    var foodClasses: [FoodItem] = []
    var foodClassesSorted: [FoodItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        print("didLoad was called in TableTableView")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 58
        
        // adds initial pre-set food classes when array is empty
        if (foodClasses.count < 2){
            addFoodClass(fName: "Pizza", fImage: "pizza.png", fCal: "600", fIndex: 0)
            addFoodClass(fName: "Spaghetti", fImage: "spaghetti.png", fCal: "200", fIndex:  1)
            addFoodClass(fName: "Ice Cream", fImage: "icecream.png", fCal: "400", fIndex: 2)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        processItems()
        tableView.reloadData()
    }
    
    func addFoodClass(fName: String, fImage: String, fCal: String, fIndex: Int) {
        let item = FoodItem(iName: fName, iImage: fImage, iCalories: fCal, iIndex: fIndex)
        foodClasses.append(item)
    }
    
    func processItems(){
        if UserDefaults.standard.bool(forKey: "sortItems") {
            foodClassesSorted = foodClasses.sorted(by: {$0.name.uppercased() < $1.name.uppercased()})
        }else {foodClassesSorted = foodClasses}
    }
    
    @IBAction func addFood(_ sender: Any) {
        let customFoodName = UserDefaults.standard.string(forKey: "defaultFood")
        addFoodClass(fName: (customFoodName ?? "Food"), fImage: "generic.jpg", fCal: "100", fIndex: (foodClasses.count))
        processItems()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodClassesSorted.count
    }

    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodCell
        
        print("tableView setting row values")
        
        // Configure the cell...
        let indexRow = indexPath.row
        cell.foodNameLabel.text = foodClassesSorted[indexRow].name
        cell.foodImage.image = UIImage(named: foodClassesSorted[indexRow].image )
        cell.calories.text = "\(foodClassesSorted[indexRow].calories ) cals"
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            foodClasses.remove(at: foodClassesSorted[row].index)
            foodClassesSorted.remove(at: row)
            
            // goes through and re-assignes indexs to reflect current item postions
            for index in (0...(foodClasses.count-1)){
                foodClasses[index].index = index
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
     //   } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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

    override func tableView(_ tableView: UITableView,
        accessoryButtonTappedForRowWith indexPath: IndexPath) {// retain for prepareForSegue
        performSegue(withIdentifier: "moreInfo", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("in prepaer func")
    }
}
