//
//  OnRunVC.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit

class OnRunVC: LocationVC {
    //***************************************************
    //MARK:- IBOutlets
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var swipeBackgroundImg: UIImageView!
    @IBOutlet weak var sliderImg: UIImageView!
    
    //***************************************************
    //MARK:- Lifecycle Hook Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped))
        sliderImg.addGestureRecognizer(swipeGesture)
        sliderImg.isUserInteractionEnabled = true
        swipeGesture.delegate = self
    }

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
