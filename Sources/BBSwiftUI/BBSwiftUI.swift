//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/10/29.
//

import Foundation

public struct BBSwiftUI {
    
    static private(set) var instance: BBSwiftUI = BBSwiftUI()
    
    var options: BBOptionsUI
    
    public var localizationLanguage: String?
    public var bundle: Bundle = Bundle.main
    
    public init(options: BBOptionsUI = BBOptionsUI()) {
        self.options = options
    }
    
    /// Default configuration of the Framework
    public static func configure(options: BBOptionsUI) {
        BBSwiftUI.instance.options = options
    }
    
    /// If you want the localize function to override the default phone language
    public static func setLocalizationLanguage(lang: String) {
        BBSwiftUI.instance.localizationLanguage = lang
    }
    
    /// If for any fucking reason you want to change the bundle the framework operates in
    public static func setBundle(bundle: Bundle) {
        BBSwiftUI.instance.bundle = bundle
    }
}
