//
//  BBColor.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
#if !os(macOS)
import SwiftUI

struct BBColor {
    struct Background {
        static var form = Color.red
        static let formSection = Color(red: 220/255.0, green: 220/255.0, blue: 220/255.0)
    }
    struct Text {
        static var lightBlack = Color(red: 32/255.0, green: 31/255.0, blue: 24/255.0)
        static var grayMedium = Color(red: 120/255.0, green: 120/255.0, blue: 120/255.0)
    }
}
#endif
