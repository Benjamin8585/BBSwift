//
//  BBSwift.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//
import Foundation


public enum LogRequestMode {
    case all, requestOnly, responseOnly, none
}

public struct BBPickerOptions {
    public var title: String = "Pick an image"
    public var message: String = "Choose where to pick an image"
    public var camera: String = "from Camera"
    public var library: String = "from Library"
}


public struct BBOptions {
    var picker: BBPickerOptions = BBPickerOptions()
    public var logRequestMode: LogRequestMode = .none
    
}

public struct BBSwift {
    
    static private(set) var instance: BBSwift = BBSwift()
    
    var options: BBOptions
    
    public var localizationLanguage: String?
    public var bundle: Bundle = Bundle.main
    
    init(options: BBOptions = BBOptions()) {
        self.options = options
    }
    
    /// Default configuration of the Framework
    public mutating func configure(options: BBOptions = BBOptions()) {
        self.options = options
    }
    
    /// If you want the localize function to override the default phone language
    public static func setLocalizationLanguage(lang: String) {
        BBSwift.instance.localizationLanguage = lang
    }
    
    /// If for any fucking reason you want to change the bundle the framework operates in
    public static func setBundle(bundle: Bundle) {
        BBSwift.instance.bundle = bundle
    }
}

