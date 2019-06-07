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
    
    func setupMapViews() {
        if let overlay = addLastRunToMap() {
            if(mapView.overlays.count > 0) {
                mapView.removeOverlays(mapView.overlays)
            }
            
            mapView.addOverlay(overlay)
        }
    }
    
    //***************************************************
    //MARK:- Methods
    func getLastRun() {
        guard let lastRun = Run.getAllRuns()?.first else {
            hideLastRun()
            return
        }
        
        showLastRun()
        setupMapViews()
        
        paceLbl.text = lastRun.pace.formatTimeToString()
        distanceLbl.text = "\(lastRun.distance.metersToKilometers(decimalPlaces: 2)) km"
        durationLbl.text = lastRun.duration.formatTimeToString()
    }
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first else {
            return nil
        }
        
        var points = [CLLocationCoordinate2D]()
        
        for point in lastRun.locations {
            let loc = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            points.append(loc)
        }
        
        return MKPolyline(coordinates: points, count: points.count)
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
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
}
