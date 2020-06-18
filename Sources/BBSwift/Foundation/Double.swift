//
//  Double.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// Transform double as displayable price
    func priceFormatted() -> String {
        return String(format: "%.02f", self.rounded(toPlaces: 2))
    }
}
