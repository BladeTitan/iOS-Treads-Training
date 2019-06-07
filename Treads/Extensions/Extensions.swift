//
//  Extensions.swift
//  Treads
//
//  Created by Armand Kamffer on 2019/06/07.
//  Copyright © 2019 Armand Kamffer. All rights reserved.
//

import Foundation

extension Double {
    func metersToKilometers(decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return ((self / 1000) * divisor).rounded() / divisor
    }
}

extension Int {
    func formatTimeToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = (self % 3600) % 60

        if(durationHours == 0) {
            return String(format: "%02d:%02d", durationMinutes, durationSeconds)
        } else {
            return String(format: "%02d:%02d:%02d", durationHours, durationMinutes, durationSeconds)
        }
    }
}
