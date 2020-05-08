//
//  timer.swift
//  FoodApp
//
//  Created by Admin on 05.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


protocol MyTimerDelegate {
    func timesChanged (time: Int)
    func timesUp ()
}

class MyTimer {
    var delegate: MyTimerDelegate?
    var initialTime: Int = 5
    var currentTime: Int = 5
    
    var timer: Timer?
    
    func start() {
       timer =
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: handleTick)
    }
    
    func handleTick (timer: Timer){
        if currentTime > 0 {
            currentTime = currentTime - 1
            delegate?.timesChanged(time: currentTime)
        }
        if currentTime <= 0 {
        delegate?.timesUp()
        }
    }
    
    func stop (){
        timer?.invalidate()
    }
    
    func reset(){
        currentTime = initialTime;
    }
    
    func setInitialTime(_ initTime: Int) {
        initialTime = initTime
        currentTime = initTime
    }
    
}
