//
//  File.swift
//  App
//
//  Created by Admin on 09.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
// stores information regarding each stop
class Stop {
    var location: String
    var time: String
    var gallons: Float
    var extra: String
    
    init(iLocation: String, iTime: String, iGallons: Float, iExtra: String){
        self.location = iLocation
        self.time = iTime
        self.gallons = iGallons
        self.extra = iExtra
    }
}
