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
