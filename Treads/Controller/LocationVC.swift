//
//  LocationVC.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, MKMapViewDelegate {

    var manager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness
        
        checkLocationAuthStatus()
    }

    func checkLocationAuthStatus() {
        if(CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            manager?.requestWhenInUseAuthorization()
        }
    }
}
