//
//  IsPreview.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

public struct IsPreview: EnvironmentKey {
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isPreview: Bool {
        get {
            return self[IsPreview.self]
        }
        set {
            self[IsPreview.self] = newValue
        }
    }
}
