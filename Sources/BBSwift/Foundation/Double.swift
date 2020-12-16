//
//  Double.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public extension Double {
    
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }

    /// Random double between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random double point number between 0 and n max
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// Transform double as displayable price
    func priceFormatted() -> String {
        return String(format: "%.02f", self.rounded(toPlaces: 2))
    }
    
    /// Transform double as displayable weight
    func weightFormatted() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        let formattedAmount = formatter.string(from: self.rounded(toPlaces: 3) as NSNumber)!
        return formattedAmount
    }
    
    func removeZeros() -> String {
         let formatter = NumberFormatter()
         let number = NSNumber(value: self)
         formatter.minimumFractionDigits = 0
         formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
         return String(formatter.string(from: number) ?? "")
     }
}
