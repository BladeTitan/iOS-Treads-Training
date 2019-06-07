//
//  LogTBC.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/06.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import UIKit

class LogTBC: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    func setupCell(run: Run) {
        paceLbl.text = run.pace.formatTimeToString()
        timeLbl.text = run.duration.formatTimeToString()
        distanceLbl.text = "\(run.distance.metersToKilometers(decimalPlaces: 2))"
        dateLbl.text = run.date.getDateString()
    }
}
