//
//  gesture.swift
//  gestureApp
//
//  Created by Admin on 11.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

// this is my “SmileGestureRecognizer” class
class SmileGestureRecognizer: UIGestureRecognizer {
    var initialPoint: CGPoint!
    var previousPoint: CGPoint!
    var initialStatus: Int!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        clearBoxes()
        print("smile: touchesBegan")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            drawBox(point)
            initialPoint = point
            initialStatus = 0
            previousPoint = point
            state = .began
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
    with event: UIEvent) {
        print("smile: touchesMoved")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            if (point.y < previousPoint.y) {
                initialStatus+=1
            }
            if ((point.y > previousPoint.y) && (initialStatus > 0) || point.x < previousPoint.x) {
                state = .failed
            } else {
                previousPoint = point
                state = .changed
                drawBox(point)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
    with event: UIEvent) {
        print("smile: touchesEnded")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            let d = distance(point, initialPoint)
            if d >= 100.0 {
                state = .ended
            } else {
                state = .failed
            }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>,
        with event: UIEvent) {
        print("smile: touchesCancelled")
        state = .cancelled
    }
    override func reset() {
        print("backslash: reset")
    }
    
    var boxViews: [UIView] = []
    func drawBox(_ point: CGPoint) {
        let boxRect = CGRect(x: point.x, y: point.y,
        width: 5.0, height: 5.0)
        let boxView = UIView(frame: boxRect)
        boxView.backgroundColor = UIColor.red
        self.view?.addSubview(boxView)
        boxViews.append(boxView)
    }
    func clearBoxes() {
        for boxView in boxViews {
            boxView.removeFromSuperview()
        }
        boxViews.removeAll()
    }
    func distance(_ point1: CGPoint, _ point2: CGPoint) -> Double {
        let xdiff = point1.x - point2.x
        let ydiff = point1.y - point2.y
        return Double(sqrt(xdiff*xdiff + ydiff*ydiff))
    }
}
