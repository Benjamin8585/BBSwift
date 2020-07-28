//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/07/28.
//

import Foundation

class CurrencySymbol {
    static let shared = CurrencySymbol()

    /// Finds the shortest currency symbol possible and formats the amount with it
    /// Note: this works around using `currencyCode` and how it displays `CA$1234.56` instead of `$1234.56`
    func currencyString(for amount: Decimal, isoCurrencyCode: String?) -> String {
        guard let isoCurrencyCode = isoCurrencyCode,
              let currencySymbol = findSymbol(for: isoCurrencyCode)
            else { return String(describing: amount) }
        return formatter(for: currencySymbol).string(for: amount) ?? String(describing: amount)
    }

    private var symbolCache = [String: String]()
    private var formatterCache = [String: NumberFormatter]()
}

extension CurrencySymbol {

    func formatter(for currencySymbol: String) -> NumberFormatter {
        if let cachedFormatter = formatterCache[currencySymbol] { return cachedFormatter }
        let formatter = NumberFormatter()
        formatter.currencySymbol = currencySymbol
        formatter.numberStyle = .currency
        formatterCache[currencySymbol] = formatter
        return formatter
    }

    func findSymbol(for currencyCode: String) -> String? {
        if let cachedCurrencyCode = symbolCache[currencyCode] { return cachedCurrencyCode }
        guard currencyCode.count < 4 else { return nil }
        let symbol = findShortestSymbol(for: currencyCode)
        symbolCache[currencyCode] = symbol
        return symbol
    }

    func findShortestSymbol(for currencyCode: String) -> String? {
        var candidates = [String]()
        for localeId in NSLocale.availableLocaleIdentifiers {
            guard let symbol = findSymbolBy(localeId: localeId, currencyCode: currencyCode) else { continue }
            if symbol.count == 1 { return symbol }
            candidates.append(symbol)
        }
        return candidates.sorted(by: { $0.count < $1.count }).first // find the shorted
    }

    func findSymbolBy(localeId: String, currencyCode: String) -> String? {
        let locale = Locale(identifier: localeId)
        guard let localCurrencyCode = locale.currencyCode else { return nil }
        return currencyCode.caseInsensitiveCompare(localCurrencyCode) == .orderedSame ? locale.currencySymbol : nil
    }
}
