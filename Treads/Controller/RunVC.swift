//
//  FirstViewController.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit
import MapKit

class RunVC: LocationVC {
    //***************************************************
    //MARK:- IBOutlets
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnCenter: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    //***************************************************
    //MARK:- Lifecycle Hook Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    //***************************************************
    //MARK:- Button Methods
    @IBAction func btnCenterPressed(_ sender: Any) {
        
    }
}

extension RunVC: CLLocationManagerDelegate {
    
}
