//
//  BBColor.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

public struct BBColor {
    public struct Background {
        public static var form = Color(red: 241/255.0, green: 241/255.0, blue: 248/255.0)
        public static let formSection = Color(red: 220/255.0, green: 220/255.0, blue: 220/255.0)
    }
    public struct Text {
        public static var lightBlack = Color(red: 32/255.0, green: 31/255.0, blue: 24/255.0)
        public static var grayMedium = Color(red: 120/255.0, green: 120/255.0, blue: 120/255.0)
    }
    public struct Banner {
        public static let red = Color(red: 231/255.0, green: 53/255.0, blue: 80/255.0)
        public static let blue = Color(red: 67/255, green: 154/255, blue: 215/255)
        public static let yellow = Color(red: 253/255.0, green: 244/255, blue: 207/255)
        public static let green = Color(red: 52/255.0, green: 121/255, blue: 97/255)
    }
    public static let green = Color(red: 113/255.0, green: 212/255, blue: 183/255)
}
