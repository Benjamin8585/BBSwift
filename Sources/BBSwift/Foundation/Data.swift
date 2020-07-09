//
//  Data.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public extension Data {
    var prettyPrinted: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }

        return prettyPrintedString
    }

    func toJson() throws -> JSON? {
        return try JSONSerialization.jsonObject(with: self, options: []) as? JSON
    }

    func toJsonArray() throws -> [JSON]? {
        return try JSONSerialization.jsonObject(with: self, options: []) as? [JSON]
    }
}
