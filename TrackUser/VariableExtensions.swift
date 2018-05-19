//
//  VariableExtensions.swift
//  TrackUser
//
//  Created by Dhruv  on 5/19/18.
//  Copyright © 2018 Dhruv . All rights reserved.
//

import Foundation
import UIKit


extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
