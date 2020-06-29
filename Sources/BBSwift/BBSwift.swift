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
    
    public var title: String
    public var message: String
    public var camera: String
    public var library: String
    
    public init(title: String = "Pick an image", message: String = "Choose where to pick an image", camera: String = "from Camera", library: String = "from Library") {
        self.title = title
        self.message = message
        self.camera = camera
        self.library = library
    }
}


public struct BBOptions {
    
    public var picker: BBPickerOptions
    public var logRequestMode: LogRequestMode
    
    public init(picker: BBPickerOptions = BBPickerOptions(), logRequestMode: LogRequestMode = .none) {
        self.picker = picker
        self.logRequestMode = logRequestMode
    }
    
}

public struct BBSwift {
    
    static private(set) var instance: BBSwift = BBSwift()
    
    var options: BBOptions
    
    public var localizationLanguage: String?
    public var bundle: Bundle = Bundle.main
    
    public init(options: BBOptions = BBOptions()) {
        self.options = options
    }
    
    /// Default configuration of the Framework
    public mutating func configure(options: BBOptions) {
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

