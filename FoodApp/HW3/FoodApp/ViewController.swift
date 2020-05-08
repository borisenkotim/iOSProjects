//
//  ViewController.swift
//  FoodApp
//
//  Created by Admin on 28.01.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyTimerDelegate {
    func timesChanged(time: Int) {
    }
    func timesUp() {
        next()
        reset()
    }
    
    var initialTime: Int = 5
    var myTimer: MyTimer?
    
    var i = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTimer = MyTimer()
        myTimer?.delegate = self
        myTimer?.setInitialTime(initialTime)
        delayTime.text = "Delay:  \(initialTime)s"
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }

    @IBOutlet weak var FoodRating: UILabel!
    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var FoodName: UILabel!
    
    @IBAction func stop(_ sender: Any) {
        myTimer?.stop()
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    @IBAction func start(_ sender: Any) {
        //myTimer?.setInitialTime(initialTime)
        myTimer?.start()
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func slider(_ sender: UISlider) {
        let initTime = Int(sender.value)
        delayTime.text = "Delay:  \(initTime)s"
        myTimer?.setInitialTime(initTime)
    }
    
    @IBOutlet weak var delayTime: UILabel!
    @IBOutlet weak var initialTimeSlider: UISlider!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    func next() {
        let foods: [String] = ["My #1 Favorite Food is...", "My #2 Favorite Food is...", "My #3 Favorite Food is..."]
        let foodNames: [String] = ["Ice Cream", "Pizza", "Pasta"]
        let foodImages: [UIImage] = [#imageLiteral(resourceName: "IceCreamCone.png"), #imageLiteral(resourceName: "GreekPizza.png"), #imageLiteral(resourceName: "pasta.png")]
        
        i = i + 1
        FoodRating.text = foods[(i%3)];
        FoodName.text = foodNames[(i%3)];
        FoodImage.image = foodImages[(i%3)];
    }
    func reset(){
        myTimer?.reset()
    }
}

