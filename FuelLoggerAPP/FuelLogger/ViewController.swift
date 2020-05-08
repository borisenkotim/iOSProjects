//
//  ViewController.swift
//  App
//
//  Created by Admin on 09.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var stop: Stop?
    var geoCoder = CLGeocoder()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocation()
        lookupLocation()
        // Do any additional setup after loading the view.
        // determine which state using location
        //state.text =
    }
    
    @IBOutlet weak var pricePerGallon: UITextField!
    
    @IBOutlet weak var gallonsFuelled: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBAction func filledInState(_ sender: UITextField) {
    }
    @IBAction func filledInGallons(_ sender: UITextField) {
        
    }
    @IBAction func filledInPrice(_ sender: UITextField) {
        
    }
    @IBAction func addPressed(_ sender: UIButton) {
        // segue to main view
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yy h:mm a"
        let formattedDate = format.string(from: date)

        stop = Stop(iLocation: state.text!.uppercased(), iTime: formattedDate, iGallons: Float(gallonsFuelled!.text ?? "0.00") ?? 0.00 , iExtra: pricePerGallon.text ?? "0.00")
        performSegue(withIdentifier: "unwindFromStop", sender: self)
    }
    
    // part of reverse geocoder
    func lookupLocation() {
        if let location = locationManager.location {
            geoCoder.reverseGeocodeLocation(location,
            completionHandler: geoCodeHandler)
        }
    }
    
    // part of reverse geocoder
    func geoCodeHandler (placemarks: [CLPlacemark]?, error: Error?) {
        if let placemark = placemarks?.first {
            //print(placemark.administrativeArea!)
            state.text = placemark.administrativeArea!
        }
    }
    
    // gets status of location authorization and performs acions based on results
    func initializeLocation() { // called from start up method
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            startLocation()
        case .denied, .restricted:
            print("location not authorized")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus) {
        if ((status == .authorizedAlways) || (status == .authorizedWhenInUse)) {
            startLocation()
            lookupLocation()   // added this
        } else {
            stopLocation()
        }
    }
    
    func startLocation () {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopLocation () {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
    didFailWithError error: Error) {
        print("locationManager error: \(error.localizedDescription)")
    }
}
