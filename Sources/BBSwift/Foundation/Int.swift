//
//  Int.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public extension Int {
    
    /// Trasnform value to hour min seconds
    func secondsToHoursMinutesSeconds() -> (hour: Int, min: Int, sec: Int) {
        return (self / 3600, (self % 3600) / 60, self % 60)
    }
}
