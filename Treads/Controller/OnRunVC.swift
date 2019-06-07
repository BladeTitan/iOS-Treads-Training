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
    @IBOutlet weak var pauseBtn: UIButton!
    
    //***************************************************
    //MARK:- Class Variables
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    
    var runDistance: Double = 0
    var avgPace: Int = 0
    var timer = Timer()
    var paceTimer = Timer()
    var timeCounter = 0
    
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
        startRun()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endRun()
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
    
    func startTimer() {
        timeLbl.text = "\(timeCounter.formatTimeToString())"
        averagePaceLbl.text = "\(avgPace.formatTimeToString())"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabels), userInfo: nil, repeats: true)
    }
    
    func startRun() {
        startTimer()
        manager?.startUpdatingLocation()
        pauseBtn.setImage(#imageLiteral(resourceName: "pauseButton"), for: UIControl.State.normal)
    }
    
    func pauseRun() {
        startLocation = nil
        lastLocation = nil
        
        timer.invalidate()
        manager?.stopUpdatingLocation()
        pauseBtn.setImage(#imageLiteral(resourceName: "resumeButton"), for: UIControl.State.normal)
    }
    
    func endRun() {
        manager?.stopUpdatingLocation()
        //save run into DB
        
        
    }
    
    @objc func updateLabels() {
        updateTimeLbl()
        updateAvgPaceLbl()
    }
    
    func updateTimeLbl() {
        timeCounter += 1
        timeLbl.text = "\(timeCounter.formatTimeToString())"
    }
    
    func updateAvgPaceLbl() {
        if(runDistance > 0) {
            avgPace = Int(Double(timeCounter) / (runDistance/1000))
            averagePaceLbl.text = "\(avgPace.formatTimeToString())"
        }
    }
    
    @IBAction func pauseBtnPressed(_ sender: Any) {
        if(timer.isValid) {
            pauseRun()
        } else {
            startRun()
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
