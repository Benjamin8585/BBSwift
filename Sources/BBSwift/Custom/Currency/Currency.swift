//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/07/28.
//

import Foundation

class CurrencySymbol {
    
    static func getLocale(for currencyCode: String) -> Locale {
        let localeId = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])
        let locale = Locale(identifier: localeId)
        return locale
    }

    static func findSymbol(for currencyCode: String) -> String? {
        let locale = CurrencySymbol.getLocale(for: currencyCode)
        return locale.currencySymbol
    }
}
