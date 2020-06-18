//
//  UIDevice.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
#if !os(macOS)
import UIKit

/// Used for determining the type of the device. Do not use it for sizes or for
public enum DeviceTypeSpecific: String {
    case simulator32Bit = "Simulator 32bit", simulator64Bit = "Simulator 64bit"
    case iPodTouch = "iPod Touch", iPodTouch5 = "iPod Touch 5", iPodTouch6 = "iPod Touch 6", iPodTouch7 = "iPod Touch 7"
    case iPhone = "iPhone", iPhone4 = "iPhone 4", iPhone4S = "iPhone 4S"
    case iPhone5 = "iPhone 5", iPhone5c = "iPhone 5c", iPhone5S = "iPhone 5S"
    case iPhone6 = "iPhone 6", iPhone6Plus = "iPhone 6 Plus", iPhone6S = "iPhone 6s", iPhone6SPlus = "iPhone 6s Plus", iPhoneSE = "iPhone SE"
    case iPhone7 = "iPhone 7", iPhone7Plus = "iPhone 7 Plus"
    case iPhone8 = "iPhone 8", iPhone8Plus = "iPhone 8 Plus", iPhoneX = "iPhone X"
    case iPhoneXS = "iPhone XS", iPhoneXSMax = "iPhone XS Max", iPhoneXR = "iPhone XR"
    case iPhone11 = "iPhone 11", iPhone11Pro = "iPhone 11 Pro", iPhone11ProMax = "iPhone 11 Pro Mac", iPhoneSE2ndGen = "iPhone SE 2nd Gen"
    case iPad = "iPad", iPad2 = "iPad 2", iPadAir = "iPad Air", iPadAir2 = "iPad Air 2"
    case iPadMini = "iPad Mini", iPadMini2 = "iPad Mini 2", iPadMini3 = "iPad Mini 3", iPadMini4 = "iPad Mini 4", iPadPro = "iPad Pro"
    case iPad2017 = "iPad (2017)", iPad2017Bis = "iPad (2017 Bis)"
    case iPadPro2ndGen = "iPad Pro 2nd Gen (WiFi)", iPadPro2ndGenCell = "iPad Pro 2nd Gen (WiFi+Cellular)"
    case iPadPro10Dot5 = "iPad Pro 10.5-inch", iPadPro10Dot5Bis = "iPad Pro 10.5-inch Bis"
    case iPad6thGen = "iPad 6th Gen (WiFi)", iPad6thGenCell = "iPad 6th Gen (WiFi+Cellular)"
    case iPad7thGen = "iPad 7th Gen 10.2-inch (WiFi)", iPad7thGenCell = "iPad 7th Gen 10.2-inch (WiFi+Cellular)"
    case iPadPro11 = "iPad Pro 11 inch (WiFi)", iPadPro11Big = "iPad Pro 11 inch (1TB, WiFi)"
    case iPadPro11Cell = "iPad Pro 11 inch (WiFi+Cellular)", iPadPro11CellBig = "iPad Pro 11 inch (1TB, WiFi+Cellular)"
    case iPadPro3rdGen = "iPad Pro 12.9 inch 3rd Gen (WiFi)", iPadPro3rdGenBig = "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)"
    case iPadPro3rdGenCell = "iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)", iPadPro3rdGenCellBig = "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular"
    case iPadPro112ndGen = "iPad Pro 11 inch 2nd Gen (WiFi)", iPadPro112ndGenCell = "iPad Pro 11 inch 2nd Gen (WiFi+Cellular)"
    case iPadPro4thGen = "iPad Pro 12.9 inch 4th Gen (WiFi)", iPadPro4thGenCell = "iPad Pro 12.9 inch 4th Gen (WiFi+Cellular)"
    case iPadMini5thGen = "iPad mini 5th Gen", iPadMini5thGenWifi = "iPad mini 5th Gen (WiFi)"
    case iPadAir3rdGen = "iPad Air 3rd Gen", iPadAir3rdGenWifi = "iPad Air 3rd Gen (WiFi)"
    case appleWatch38 = "Apple Watch 38mm case", appleWatch42 = "Apple Watch 42mm case"
    case appleWatch38Series = "Apple Watch Series 1 38mm case", appleWatch42Series = "Apple Watch Series 1 42mm case"
    case appleWatch38Series2 = "Apple Watch Series 2 38mm case", appleWatch42Series2 = "Apple Watch Series 2 42mm case"
    case appleWatch38Series3 = "Apple Watch Series 3 38mm case (GPS)", appleWatch42Series3 = "Apple Watch Series 3 42mm case (GPS)"
    case appleWatch38Series3Cell = "Apple Watch Series 3 38mm case (GPS+Cellular)", appleWatch42Series3Cell = "Apple Watch Series 3 42mm case (GPS+Cellular)"
    case appleWatch40Series4 = "Apple Watch Series 4 40mm case (GPS)", appleWatch44Series4 = "Apple Watch Series 4 44mm case (GPS)"
    case appleWatch40Series4Cell = "Apple Watch Series 4 40mm case (GPS+Cellular)", appleWatch44Series4Cell = "Apple Watch Series 4 44mm case (GPS+Cellular)"
    case appleWatch40Series5 = "Apple Watch Series 5 40mm case (GPS)", appleWatch44Series5 = "Apple Watch Series 5 44mm case (GPS)"
    case appleWatch40Series5Cell = "Apple Watch Series 5 40mm case (GPS+Cellular)", appleWatch44Series5Cell = "Apple Watch Series 5 44mm case (GPS+Cellular)"
    case appleTV = "Apple TV (1st Gen)", appleTV2 = "Apple TV (2nd Gen)", appleTV3 = "Apple TV (3nd Gen)", appleTV3Bis = "Apple TV (3th Gen Bis)", appleTVHD = "Apple TV HD (4th Gen)", appleTV4K = "Apple TV 4K"
    case unknown = "Unknown Device", unknowniPhone = "iPhone (Version Not detected)"
    case unknowniPad = "iPad (Version Not detected)", unknowniPodTouch = "iPod Touch (Version Not detected)"
}

public enum DeviceType: String {
    case simulator = "Simulator", iPhone = "iPhone", iPod = "iPod", iPad = "iPad", appleTv = "AppleTV", watch = "AppleWatch", unknown = "Unknown"
}

public struct DeviceSize {

    public let width: CGFloat
    public let height: CGFloat

    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
}

public func == (lhs: DeviceSize, rhs: DeviceSize) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}

public func != (lhs: DeviceSize, rhs: DeviceSize) -> Bool {
    return !(lhs == rhs)
}

public extension UIDevice {

    /// Next device type. You have to consider that this function could fail and return unknown with next devices so use with caution
    public var deviceSpecificType: DeviceTypeSpecific {
        let deviceName: DeviceTypeSpecific? = self.deviceNamesByCode[self.deviceCode]

        if let dev = deviceName {
            return dev
        } else {
            // Device not found. At least guess main device type from string contents:
            if self.deviceCode.range(of: "iPod") != nil {
                return .unknowniPodTouch
            } else if self.deviceCode.range(of: "iPad") != nil {
                return .unknowniPad
            } else if self.deviceCode.range(of: "iPhone") != nil {
                return .unknowniPhone
            } else {
                return .unknown
            }
        }
    }

    /// General device type. You have to consider that this function could fail and return unknown with next devices so use with caution
    public var deviceType: DeviceType {
        switch self.deviceSpecificType {
        case .simulator32Bit, .simulator64Bit:
            return .simulator
        case .iPhone, .iPhone4, .iPhone4S, .iPhone5, .iPhone5c, .iPhone5S,
             .iPhone6, .iPhone6S, .iPhone6Plus, .iPhone6SPlus, .iPhoneSE,
             .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus, .iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR,
             .iPhone11, .iPhone11Pro, .iPhone11ProMax, .iPhoneSE2ndGen,
             .unknowniPhone:
            return .iPhone
        case .iPodTouch, .iPodTouch5, .iPodTouch6, .iPodTouch7, .unknowniPodTouch:
            return .iPod
        case .iPad, .iPad2, .iPadAir, .iPadAir2, .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadPro,
             .iPad2017, .iPad2017Bis, .iPadPro2ndGen, .iPadPro2ndGenCell, .iPadPro10Dot5, .iPadPro10Dot5Bis,
             .iPad6thGen, .iPad6thGenCell, .iPad7thGen, .iPad7thGenCell,
             .iPadPro11, .iPadPro11Big, .iPadPro11Cell, .iPadPro11CellBig,
             .iPadPro3rdGen, .iPadPro3rdGenBig, .iPadPro3rdGenCell, .iPadPro3rdGenCellBig,
             .iPadPro112ndGen, .iPadPro112ndGenCell,
             .iPadPro4thGen, .iPadPro4thGenCell,
             .iPadMini5thGen, .iPadMini5thGenWifi,
             .iPadAir3rdGen, .iPadAir3rdGenWifi,
             .unknowniPad:
            return .iPad
        case .appleWatch38, .appleWatch42,
             .appleWatch38Series, .appleWatch42Series,
             .appleWatch38Series2, .appleWatch42Series2,
             .appleWatch38Series3, .appleWatch42Series3, .appleWatch38Series3Cell, .appleWatch42Series3Cell,
             .appleWatch40Series4, .appleWatch44Series4, .appleWatch40Series4Cell, .appleWatch44Series4Cell,
             .appleWatch40Series5, .appleWatch44Series5, .appleWatch40Series5Cell, .appleWatch44Series5Cell:
            return .watch
        case .appleTV, .appleTV2, .appleTV3, .appleTV3Bis, .appleTVHD, .appleTV4K:
            return .appleTv
        case .unknown:
            return .unknown
        }
    }

    public var size: DeviceSize {
        return DeviceSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }

    public var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    public var isRetina: Bool {
        return UIScreen.main.scale >= 2.0
    }
    public var isLandscapeRight: Bool {
        return self.orientation == UIDeviceOrientation.landscapeRight
    }
    public var isLandscapeLeft: Bool {
        return self.orientation == UIDeviceOrientation.landscapeLeft
    }
    public var isLandscape: Bool {
        return isLandscapeLeft || isLandscapeRight
    }
    public var isPortraitDefault: Bool {
        return self.orientation == UIDeviceOrientation.portrait
    }
    public var isPortraitReverse: Bool {
        return self.orientation == UIDeviceOrientation.portraitUpsideDown
    }
    public var isPortrait: Bool {
        return isPortraitReverse || isPortraitDefault
    }

    /// Return the code string of the device
    private var deviceCode: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }

    /// To retrieve device name (the type)
    public var deviceName: String {
        var deviceName: String? = deviceNamesByCode[self.deviceCode]?.rawValue
        if let dev = deviceName {
            return dev
        } else {
            // Not found on database. At least guess main device type from string contents:
            if self.deviceCode.range(of: "iPod") != nil {
                deviceName = "iPod Touch (Version Not detected)"
            } else if self.deviceCode.range(of: "iPad") != nil {
                deviceName = "iPad (Version Not detected)"
            } else if self.deviceCode.range(of: "iPhone") != nil {
                deviceName = "iPhone (Version Not detected)"
            } else {
                deviceName = "Device not found"
            }
            return deviceName!
        }
    }

    // swiftlint:disable colon
    var deviceNamesByCode :[String: DeviceTypeSpecific] {
        return ["i386"      : .simulator32Bit,
                "x86_64"    : .simulator64Bit,
                "iPod1,1"   : .iPodTouch,      // (Original)
            "iPod2,1"   : .iPodTouch,      // (Second Generation)
            "iPod3,1"   : .iPodTouch,      // (Third Generation)
            "iPod4,1"   : .iPodTouch,      // (Fourth Generation)
            "iPod5,1"   : .iPodTouch5,
            "iPod7,1"   : .iPodTouch6,
            "iPod9,1"   : .iPodTouch7,
            "iPhone1,1" : .iPhone,          // (Original)
            "iPhone1,2" : .iPhone,          // (3G)
            "iPhone2,1" : .iPhone,          // (3GS)
            "iPhone3,1" : .iPhone4,        // (GSM)
            "iPhone3,3" : .iPhone4,        // (CDMA/Verizon/Sprint)
            "iPhone4,1" : .iPhone4S,       //
            "iPhone5,1" : .iPhone5,        // (model A1428, AT&T/Canada)
            "iPhone5,2" : .iPhone5,        // (model A1429, everything else)
            "iPhone5,3" : .iPhone5c,       // (model A1456, A1532 | GSM)
            "iPhone5,4" : .iPhone5c,       // (model A1507, A1516, A1526 (China), A1529 | Global)
            "iPhone6,1" : .iPhone5S,       // (model A1433, A1533 | GSM)
            "iPhone6,2" : .iPhone5S,       // (model A1457, A1518, A1528 (China), A1530 | Global)
            "iPhone7,1" : .iPhone6Plus,   //
            "iPhone7,2" : .iPhone6,        //
            "iPhone8,1":  .iPhone6S,
            "iPhone8,2":  .iPhone6SPlus,
            "iPhone8,4":  .iPhoneSE,
            "iPhone9,1":  .iPhone7,
            "iPhone9,3":  .iPhone7,
            "iPhone9,2":  .iPhone7Plus,
            "iPhone9,4":  .iPhone7Plus,
            "iPhone10,1": .iPhone8, // (CDMA)
            "iPhone10,2": .iPhone8Plus, // (CDMA)
            "iPhone10,3": .iPhoneX, // (CDMA)
            "iPhone10,4": .iPhone8, // (GSM)
            "iPhone10,5": .iPhone8Plus, // (GSM)
            "iPhone10,6": .iPhoneX, // (GSM)
            "iPhone11,2": .iPhoneXS,
            "iPhone11,4": .iPhoneXSMax,
            "iPhone11,8": .iPhoneXR,
            "iPhone12,1": .iPhone11,
            "iPhone12,3": .iPhone11Pro,
            "iPhone12,5": .iPhone11ProMax,
            "iPhone12,8": .iPhoneSE2ndGen,
            "iPad1,1"   : .iPad,            // (Original)
            "iPad2,1"   : .iPad2,          //
            "iPad3,1"   : .iPad,            // (3rd Generation)
            "iPad3,4"   : .iPad,            // (4th Generation)
            "iPad2,5"   : .iPadMini,       // (Original)
            "iPad4,1"   : .iPadAir,        // 5th Generation iPad (iPad Air) - Wifi
            "iPad4,2"   : .iPadAir,        // 5th Generation iPad (iPad Air) - Cellular
            "iPad4,3"   : .iPadAir,        // 5th Generation iPad (iPad Air)
            "iPad4,4"   : .iPadMini2,       // (2nd Generation iPad Mini - Wifi)
            "iPad4,5"   : .iPadMini2,       // (2nd Generation iPad Mini - Cellular)
            "iPad4,6"   : .iPadMini2,       // (2nd Generation iPad Mini)
            "iPad4,7"   : .iPadMini3,       // (3th Generation iPad Mini)
            "iPad4,8"   : .iPadMini3,       // (3th Generation iPad Mini)
            "iPad4,9"   : .iPadMini3,       // (3th Generation iPad Mini)
            "iPad5,1"   : .iPadMini4,       // (4th Generation iPad Mini)
            "iPad5,2"   : .iPadMini4,       // (4th Generation iPad Mini )
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad6,3"   : .iPadPro, // iPad PRO 12.9 Wifi (model A1673)
            "iPad6,4"   : .iPadPro, // iPad PRO 12.9 Wifi + Cellular (model A1674,A1675)
            "iPad6,7"   : .iPadPro, // iPad PRO 9.7 Wifi (model A1584)
            "iPad6,8"   : .iPadPro, // iPad PRO 9.7 Wifi + Cellular (model A1652)
            "iPad6,11" : .iPad2017,
            "iPad6,12" : .iPad2017Bis,
            "iPad7,1" : .iPadPro2ndGen,
            "iPad7,2" : .iPadPro2ndGenCell,
            "iPad7,3" : .iPadPro10Dot5,
            "iPad7,4" : .iPadPro10Dot5Bis,
            "iPad7,5" : .iPad6thGen,
            "iPad7,6" : .iPad6thGenCell,
            "iPad7,11" : .iPad7thGen,
            "iPad7,12" : .iPad7thGenCell,
            "iPad8,1" : .iPadPro11,
            "iPad8,2" : .iPadPro11Big,
            "iPad8,3" : .iPadPro11Cell,
            "iPad8,4" : .iPadPro11CellBig,
            "iPad8,5" : .iPadPro11Cell,
            "iPad8,6" : .iPadPro3rdGen,
            "iPad8,7" : .iPadPro3rdGenBig,
            "iPad8,8" : .iPadPro3rdGenCellBig,
            "iPad8,9" : .iPadPro112ndGen,
            "iPad8,10" : .iPadPro112ndGenCell,
            "iPad8,11" : .iPadPro4thGen,
            "iPad8,12" : .iPadPro4thGenCell,
            "iPad11,1" : .iPadMini5thGen,
            "iPad11,2" : .iPadMini5thGenWifi,
            "iPad11,3" : .iPadAir3rdGen,
            "iPad11,4" : .iPadAir3rdGenWifi,
            "Watch1,1" : .appleWatch38, // Apple Watch 38mm case
            "Watch1,2" : .appleWatch42, // Apple Watch 42mm case
            "Watch2,6" : .appleWatch38Series, // Apple Watch Series 1 38mm case
            "Watch2,7" : .appleWatch42Series, // Apple Watch Series 1 42mm case
            "Watch2,3" : .appleWatch38Series2, // Apple Watch Series 2 38mm case
            "Watch2,4" : .appleWatch42Series2, // Apple Watch Series 2 42mm case
            "Watch3,1" : .appleWatch38Series3Cell, // Apple Watch Series 3 38mm case (GPS+Cellular)
            "Watch3,2" : .appleWatch42Series3Cell, // Apple Watch Series 3 42mm case (GPS+Cellular)
            "Watch3,3" : .appleWatch38Series3, // Apple Watch Series 3 38mm case (GPS)
            "Watch3,4" : .appleWatch42Series3Cell, // Apple Watch Series 3 42mm case (GPS)
            "Watch4,1" : .appleWatch40Series4, // Apple Watch Series 4 40mm case (GPS)
            "Watch4,2" : .appleWatch44Series4, // Apple Watch Series 4 44mm case (GPS)
            "Watch4,3" : .appleWatch40Series4Cell, // Apple Watch Series 4 40mm case (GPS+Cellular)
            "Watch4,4" : .appleWatch44Series4Cell, // Apple Watch Series 4 44mm case (GPS+Cellular)
            "Watch5,1" : .appleWatch40Series5, // Apple Watch Series 5 40mm case (GPS)
            "Watch5,2" : .appleWatch40Series5, // Apple Watch Series 5 44mm case (GPS)
            "Watch5,3" : .appleWatch44Series5Cell, // Apple Watch Series 5 40mm case (GPS+Cellular)
            "Watch5,4" : .appleWatch44Series5Cell, // Apple Watch Series 5 44mm case (GPS+Cellular)
            "AppleTV1,1": .appleTV, // Apple TV (1st Gen)
            "AppleTV2,1": .appleTV2, // Apple TV (2nd Gen)
            "AppleTV3,1": .appleTV3, // Apple TV (3rd Gen)
            "AppleTV3,2": .appleTV3Bis, // Apple TV (3rd Gen)
            "AppleTV5,3": .appleTVHD, // Apple TV HD (4th Gen)
            "AppleTV6,2": .appleTV4K // Apple TV 4K
        ]
    }
}

public extension UIDevice {

    /// Check if low power mode enabled on device
    public var isLowPowerMode: Bool {
        return ProcessInfo.processInfo.isLowPowerModeEnabled
    }
}
#endif
