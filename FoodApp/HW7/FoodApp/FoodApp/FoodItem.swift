//
//  FoodItem.swift
//  FoodApp
//

import Foundation

class FoodItem {
    var name: String
    var imageFileName: String
    var caloriesPerServing: Int
    var id: String
    var scheduled: Bool
    
    init(name: String, imageFileName: String, caloriesPerServing: Int) {
        self.name = name
        self.imageFileName = imageFileName
        self.caloriesPerServing = caloriesPerServing
        self.id = UUID().uuidString
        self.scheduled = false
    }
}
