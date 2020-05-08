//
//  ViewController.swift
//  gestureApp
//
//  Created by Admin on 11.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var smileGestureRecognizer = SmileGestureRecognizer()
    var frownGestureRecognizer = FrownGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        let panGestureRecognizer = UIPanGestureRecognizer(target: self,
        action: #selector(handlePan))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        smileGestureRecognizer =
        SmileGestureRecognizer(target: self,
        action: #selector(handleSmile))
        smileGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(smileGestureRecognizer)
        
        frownGestureRecognizer =
        FrownGestureRecognizer(target: self,
        action: #selector(handleFrown))
        frownGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(frownGestureRecognizer)
        
        feelingLabel.text = ""
    }
    // In ViewController...
    @objc func handleSmile(_ sender: SmileGestureRecognizer) {
        if sender.state == .ended {
            print("smile detected")
            image.image = #imageLiteral(resourceName: "smile.png")
            feelingLabel.text = "Tastes Good!"
        }
    }
    @objc func handleFrown(_ sender: FrownGestureRecognizer) {
        if sender.state == .ended {
            print("frown detected")
            image.image = #imageLiteral(resourceName: "frown.png")
            feelingLabel.text = "Tastes Bad!"
        }
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        clearBoxes()
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var feelingLabel: UILabel!
    
    @IBAction func tapDetected (_ sender: UIGestureRecognizer) {
        let point = sender.location(in: self.view)
        let x = Int(point.x)
        let y = Int(point.y)
        print("tap detected at (\(x),\(y))")
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
    shouldReceive touch: UITouch) -> Bool {
    if touch.view is UIButton {
    return false
    }
    // Add more checks for other types of view elements, as needed
    return true
    }
    @objc func handlePan (_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self.view)
        let x = Int(point.x)
        let y = Int(point.y)
        drawBox(point)
        if (sender.state == .began) {
            print("pan began at (\(x),\(y))")
        }
        if (sender.state == .changed) {
            print ("pan moved to (\(x),\(y))")
        }
        if (sender.state == .ended) {
            print ("pan ended at (\(x),\(y))")
            clearBoxes()
        }
    }
    
    var boxViews: [UIView] = []
    func drawBox(_ point: CGPoint) {
        let boxRect = CGRect(x: point.x, y: point.y, width: 5.0, height: 5.0)
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
        image.image = nil
        feelingLabel.text = ""
        smileGestureRecognizer.clearBoxes()
        frownGestureRecognizer.clearBoxes()
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
    -> Bool {
        if gestureRecognizer is SmileGestureRecognizer {
            if otherGestureRecognizer is FrownGestureRecognizer {
                return true
            }
        }
        if gestureRecognizer is FrownGestureRecognizer {
            if otherGestureRecognizer is SmileGestureRecognizer {
                return true
            }
        }
        
        return false
    }
}

