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
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunClosedBtn: UIButton!
    @IBOutlet weak var lastRunStackView: UIStackView!
    @IBOutlet weak var lastRunBackgroundView: UIView!
    
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
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    //***************************************************
    //MARK:- Methods
    func getLastRun() {
        guard let lastRun = Run.getAllRuns()?.first else {
            hideLastRun()
            return
        }
        
        showLastRun()
        paceLbl.text = lastRun.pace.formatTimeToString()
        distanceLbl.text = "\(lastRun.distance.metersToKilometers(decimalPlaces: 2)) km"
        durationLbl.text = lastRun.duration.formatTimeToString()
        
        
    }
    
    func hideLastRun() {
        lastRunClosedBtn.isHidden = true
        lastRunBackgroundView.isHidden = true
        lastRunClosedBtn.isHidden = true
    }
    
    func showLastRun() {
        lastRunClosedBtn.isHidden = false
        lastRunBackgroundView.isHidden = false
        lastRunClosedBtn.isHidden = false
    }
    
    //***************************************************
    //MARK:- Button Methods
    @IBAction func btnCenterPressed(_ sender: Any) {
        
    }
    
    @IBAction func lastRunClosedBtnPressed(_ sender: Any) {
        hideLastRun()
    }
}

extension RunVC: CLLocationManagerDelegate {
    
}
