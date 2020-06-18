//
//  Locale.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public extension Locale {
    
    /// Return the code and symbol of the currency from the country provided.
    ///   Ex: "us" return code "USD" and symbol: $
    static func currencyFromCountryCode(code: String) -> (code: String?, symbol: String?)? {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code]))
        return (code: locale.currencyCode, symbol: locale.currencySymbol)
    }
}
