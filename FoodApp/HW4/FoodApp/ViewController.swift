//
//  ViewController.swift
//  FoodApp
//

import UIKit

class ViewController: UIViewController {

    var foodIndex = 0
    var foodNames = ["Pizza!", "Spaghetti!", "Ice Cream"]
    var imageNames = ["pizza.png", "spaghetti.png", "icecream.png"]
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        foodIndex = (foodIndex + 1) % foodNames.count
        updateFood()
    }
    
    func updateFood() {
        headingLabel.text = "My #\(foodIndex+1) favorite food is..."
        foodLabel.text = foodNames[foodIndex]
        foodImageView.image = UIImage(named: imageNames[foodIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodIndex = 0
        updateFood()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToSecondViewButton") {
        let secondVC = segue.destination as! AddFoodViewController
            secondVC.messageFromFirstView =
            "Enter name of food #\(foodNames.count+1)"
        }
    }
    
    @IBAction func unwindFromSecondView (sender: UIStoryboardSegue) {
    let secondVC = sender.source as! AddFoodViewController
    let buttonTapped = secondVC.buttonTapped
        if buttonTapped == "none" {print("none was tapped")}
        if buttonTapped == "cancel" {print("cancel was tapped")}
        if buttonTapped == "save" {
            print("save was tapped")
            if let addedFoodLabel = secondVC.addedFoodLabel {
                if (addedFoodLabel != "-1"
                    && addedFoodLabel.trimmingCharacters(in: .whitespaces) != ""
                    && !addedFoodLabel.isEmpty){
                    addFood(food: addedFoodLabel)
                }
            }
        }
    }
    
    func addFood (food: String){
        // when the user types in a new food to be added
        foodNames.append(food)
        imageNames.append("generic.jpg")
        foodIndex = foodNames.count-1
        updateFood()
    }

}

