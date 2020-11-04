//
//  Int.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public extension Int {

    /// Random integer between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random Int point number between 0 and n max
    static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }

    ///  Random integer between min and max
    ///
    /// - Parameters:
    ///   - min:    Interval minimun
    ///   - max:    Interval max
    /// - Returns:  Returns a random Int point number between 0 and n max
    static func random(min: Int, max: Int) -> Int {
        return Int.random(n: max - min + 1) + min
    }
    
    /// Trasnform value to hour min seconds
    func secondsToHoursMinutesSeconds() -> (hour: Int, min: Int, sec: Int) {
        return (self / 3600, (self % 3600) / 60, self % 60)
    }
    
    var secondsToHoursMinutesSecondsFormatted: String {
        let time = self.secondsToHoursMinutesSeconds()
        if time.hour > 0 {
            if time.min > 0 {
                if time.sec > 0 {
                    return String(format: "%02dH %02dmin %02dsec", time.hour, time.min, time.sec)
                } else {
                    return String(format: "%02dH %02dmin", time.hour, time.min)
                }
            } else {
                if time.sec > 0 {
                    return String(format: "%02dH %02dsec", time.hour, time.sec)
                } else {
                    return String(format: "%02dH", time.hour)
                }
            }
        } else {
            if time.min > 0 {
                if time.sec > 0 {
                    return String(format: "%02dmin %02dsec", time.hour, time.min, time.sec)
                } else {
                    return String(format: "%02dmin", time.hour, time.min)
                }
            } else {
                if time.sec > 0 {
                    return String(format: "%02dsec", time.hour, time.sec)
                } else {
                    return "0"
                }
            }
        }
    }
}
