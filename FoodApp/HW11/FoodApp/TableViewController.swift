//
//  TableViewController.swift
//  FoodApp
//
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var managedFood: [NSManagedObject] = []
    var managedObjectContext: NSManagedObjectContext!
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        print("didLoad was called in TableTableView")
        tableView.rowHeight = 58
        
        managedFood = getData()
        tableView.reloadData()
    }
    
    @IBAction func AddPressed(_ sender: UIBarButtonItem) {
        let foodImages = ["pizza.png", "spaghetti.png", "icecream.png", "taco.jpg", "pie.png"]
        let foodNames = ["Pizza", "Spaghetti", "Ice Cream", "Taco", "Pie"]
        let index = Int.random(in: 0..<foodImages.count)
        let randomCal = Int.random(in: 100...500)
        
        let myFood =  addFood(fName: foodNames[index], fImage: foodImages[index], fCal: Int32(randomCal))
        
        managedFood.append(myFood)
        tableView.reloadData()
    }
    
    func addFood(fName: String, fImage: String, fCal: Int32) -> NSManagedObject {
        let food = NSEntityDescription.insertNewObject(forEntityName: "FoodItem", into: self.managedObjectContext)
        food.setValue(fName, forKey: "name")
        food.setValue(fImage, forKey: "imageFileName")
        food.setValue(fCal, forKey: "calories")
        appDelegate.saveContext()
        return food
    }
    
    func getData() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FoodItem")
        var foods: [NSManagedObject] = []
        do {
            foods = try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("foods error: \(error)")
        }
        return foods
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return managedFood.count
    }

    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodCell
        
        print("tableView setting row values")
        
        // Configure the cell...
        let indexRow = indexPath.row
        let food = managedFood[indexRow]
        cell.foodNameLabel.text = food.value(forKey: "name") as? String
        cell.foodImage.image = UIImage(named: food.value(forKey: "imageFileName") as! String)
        cell.calories.text = String(food.value(forKey: "calories") as! Int32) + " Cal"
        
        return cell
    }

    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//
//        return true
//    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       // currentFoodLabel = managedFood[indexPath.row].name
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            let food = managedFood[row]
            removeFood(food)
            managedFood.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
     //   } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func removeFood(_ food: NSManagedObject) {
        managedObjectContext.delete(food)
        appDelegate.saveContext()
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("This cell from the chat list was selected: \(indexPath.row)")
//        currentFoodLabel = foodClasses[indexPath.row].name
//        performSegue(withIdentifier: "goToMap", sender: self)
//    }

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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "goToMap") {
//        let secondVC = segue.destination as! ViewController
//            secondVC.foodName = currentFoodLabel
//        }
//    }
    
}
