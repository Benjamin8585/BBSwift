//
//  String.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import CryptoSwift

public extension String {
    
    /// Trasnform string to url
    func toUrl() -> URL? {
        return URL(string: self)
    }

    /// Remove quotes if this is a quoted string
    func unquoted() -> String {
        var formatted = self
        let isSingleQuoted = formatted.first == "'" && formatted.last == "'" && formatted.count > 1
        let isDoubleQuoted = formatted.first == "\"" && formatted.last == "\"" && formatted.count > 1
        if isSingleQuoted || isDoubleQuoted {
            formatted.removeFirst()
            formatted.removeLast()
        }
        return formatted
    }

    /// Return emoji flag accourding to country value provided
    func getFlagEmoji() -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in self.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }

    /// If the string is an empty string make it nil
    func emptyFiltered() -> String? {
        return self.count == 0 ? nil : self
    }
    
    /// If the string is just some space ex: "      " return nil
    func emptySpaceFiltered() -> String? {
        return self.count == 0 ? nil : self
    }

    /// Return language name according to code provided.
    /// ex: fr return français.
    func languageName() -> String? {
        return NSLocale(localeIdentifier: self).localizedString(forLanguageCode: self) ?? NSLocale.current.localizedString(forLanguageCode: self)
    }

    /// Check if the string is a valid email
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    /// Localize the string. the params are here if you want to pass dynamic data
    ///     If you want the function to localize to a specific language call BBSwift.setLocalizationLanguage()
    ///     By default this will search for l
    func localized(params: [String] = []) -> String {
        var bundle = BBSwift.instance.bundle
        if let lang = BBSwift.instance.localizationLanguage {
            let path = BBSwift.instance.bundle.path(forResource: lang, ofType: "lproj")
            if let path = path, let bundleCreated = Bundle(path: path) {
                bundle = bundleCreated
            }
        }
        return String(format: NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: ""), arguments: params)
    }

    /// Transform a date string from mongoDb format to a swift Date object
    func toIso8601Date() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
    
    /// MARK: Encryption
    
    func aesEncrypt(key: String, iv: String) throws -> String {
        let dec = try AES(key: key, iv: iv, padding: .pkcs7).encrypt(Array(self.utf8))
        let decData = Data(bytes: dec, count: Int(dec.count)).base64EncodedString(options: .lineLength64Characters)
        return decData
    }

    
    func aesDecrypt(key: String, iv: String) throws -> String {
        guard let data = Data(base64Encoded: value, options: .ignoreUnknownCharacters) else {
            throw BBSwiftError.base64Invalid
        }
        let dec = try AES(key: key, iv: iv, padding: .pkcs7).decrypt(data.bytes)
        let decData = Data(bytes: dec, count: Int(dec.count))
        guard let result = String(data: decData, encoding: .utf8) else {
            throw BBSwiftError.base64Invalid
        }
        return result
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }

        return String(data: data as Data, encoding: String.Encoding.utf8)
    }

    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }

        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }

}
