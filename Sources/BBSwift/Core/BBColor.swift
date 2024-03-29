//
//  BBColor.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

public struct Colorable {
    var lightMode: Color
    var darkMode: Color
    
    func getColor(scheme: ColorScheme? = nil) -> Color {
        if let scheme = scheme {
            return scheme == .light ? self.lightMode : self.darkMode
        } else {
            return self.lightMode
        }
    }
}

#if os(iOS)
public struct UIColorable {
    var lightMode: UIColor
    var darkMode: UIColor
    
    func getColor(scheme: ColorScheme? = nil) -> UIColor {
        if let scheme = scheme {
            return scheme == .light ? self.lightMode : self.darkMode
        } else {
            return self.lightMode
        }
    }
}
#endif

public struct BBColor {
    public struct Background {
        public static var form: Colorable = Colorable(
            lightMode: Color(red: 241/255.0, green: 241/255.0, blue: 248/255.0),
            darkMode: Color(red: 60/255.0, green: 60/255.0, blue: 60/255.0)
        )
        public static var formLine: Colorable = Colorable(
            lightMode: Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0),
            darkMode: Color(red: 80/255.0, green: 80/255.0, blue: 80/255.0)
        )
        public static var formSection: Colorable = Colorable(
            lightMode: Color(red: 220/255.0, green: 220/255.0, blue: 220/255.0),
            darkMode: Color(red: 80/255.0, green: 80/255.0, blue: 80/255.0)
        )
        public static var blackOrWhite: Colorable = Colorable(
            lightMode: Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0),
            darkMode: Color(red: 0/255.0, green: 0/255.0, blue: 0/255.0)
        )
    }
    public struct Text {
        public static var main: Colorable = Colorable(
            lightMode: Color(red: 32/255.0, green: 31/255.0, blue: 24/255.0),
            darkMode: Color(red: 245/255.0, green: 245/255.0, blue: 247/255.0)
        )
        
        #if os(iOS)
        public static var mainUI: UIColorable = UIColorable(
            lightMode: UIColor(red: 32/255.0, green: 31/255.0, blue: 24/255.0, alpha: 1.0),
            darkMode: UIColor(red: 245/255.0, green: 245/255.0, blue: 247/255.0, alpha: 1.0)
        )
        #endif
        public static var sectionTitleColor: Colorable = Colorable(
            lightMode: Color(red: 120/255.0, green: 120/255.0, blue: 120/255.0),
            darkMode: Color(red: 220/255.0, green: 220/255.0, blue: 220/255.0)
        )
        
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
