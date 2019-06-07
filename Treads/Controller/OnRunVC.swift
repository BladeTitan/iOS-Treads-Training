//
//  OnRunVC.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit
import MapKit

class OnRunVC: LocationVC {
    //***************************************************
    //MARK:- IBOutlets
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var swipeBackgroundImg: UIImageView!
    @IBOutlet weak var sliderImg: UIImageView!
    
    //***************************************************
    //MARK:- Class Variables
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var runDistance: Double = 0
    
    //***************************************************
    //MARK:- Lifecycle Hook Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped))
        sliderImg.addGestureRecognizer(swipeGesture)
        sliderImg.isUserInteractionEnabled = true
        swipeGesture.delegate = self
        manager?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager?.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        manager?.stopUpdatingLocation()
    }
    
    //***************************************************
    //MARK:- Methods
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) {
        let minAdjust: CGFloat = 78
        let maxAdjust: CGFloat = 132.5
        
        if let sliderView = sender.view {
            if(sender.state == UIGestureRecognizer.State.changed || sender.state == UIGestureRecognizer.State.began) {
                let translation = sender.translation(in: self.view)
                
                if(sliderView.center.x >= swipeBackgroundImg.center.x - minAdjust && sliderView.center.x <= swipeBackgroundImg.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
                }
                else if(sliderView.center.x >= swipeBackgroundImg.center.x + maxAdjust) {
                    sliderView.center.x = swipeBackgroundImg.center.x + maxAdjust
                    
                    dismiss(animated: true, completion: nil)
                }
                else if(sliderView.center.x <= swipeBackgroundImg.center.x + minAdjust) {
                    UIView.animate(withDuration: 0.1) {
                        sliderView.center.x = self.swipeBackgroundImg.center.x - minAdjust
                    }
                }
                
                sender.setTranslation(CGPoint.zero, in: self.view)
            }
            else if(sender.state == UIGestureRecognizer.State.ended) {
                UIView.animate(withDuration: 0.1) {
                    sliderView.center.x = self.swipeBackgroundImg.center.x - minAdjust
                }
            }
        }
    }
}

extension OnRunVC: UIGestureRecognizerDelegate {
    
}

extension OnRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (startLocation == nil) {
            startLocation = locations.first
        } else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            distanceLbl.text = "\(runDistance.metersToKilometers(decimalPlaces: 2))"
        }

        lastLocation = locations.last
    }
}
