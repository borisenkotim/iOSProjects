//
//  FoodItem.swift
//  FoodApp5
//
//  Created by Admin on 18.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class FoodItem {
    var name: String
    var image: String
    var calories: String
    var index: Int
    
    init(iName: String, iImage: String, iCalories: String, iIndex: Int){
        self.name = iName
        self.image = iImage
        self.calories = iCalories
        self.index = iIndex
    }
}
