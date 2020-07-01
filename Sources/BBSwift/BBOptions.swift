//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/06/29.
//

import Foundation
import SwiftUI

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

public struct BBBannerOptions {
    
    public var apiErrorTitle: String
    
    public init(apiErrorTitle: String = "API Error") {
        self.apiErrorTitle = apiErrorTitle
    }
}


public struct BBOptions {
    
    public var picker: BBPickerOptions
    public var banner: BBBannerOptions
    public var logRequestMode: LogRequestMode
    
    public init(picker: BBPickerOptions = BBPickerOptions(), logRequestMode: LogRequestMode = .none, banner: BBBannerOptions = BBBannerOptions()) {
        self.picker = picker
        self.logRequestMode = logRequestMode
        self.banner = banner
    }
    
}
