//
//  FirstViewController.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit
import MapKit

class RunVC: UIViewController {
    //***************************************************
    //MARK:- IBOutlets
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnCenter: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    //***************************************************
    //MARK:- Lifecycle Hook Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //***************************************************
    //MARK:- Button Methods
    @IBAction func btnStartPressed(_ sender: Any) {
        
    }
    
    @IBAction func btnCenterPressed(_ sender: Any) {
        
    }
}

