//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/10/29.
//

import Foundation
import SwiftUI

public enum LogRequestMode {
    case all, requestOnly, responseOnly, none
}

public struct BBPickerOptions {
    
    public var imageTitle: String
    public var imageMessage: String
    public var videoTitle: String
    public var videoMessage: String
    public var camera: String
    public var library: String
    
    public init(imageTitle: String = "Pick an image", imageMessage: String = "Choose where to pick an image", videoTitle: String = "Pick a video", videoMessage: String = "Choose where to pick a video", camera: String = "from Camera", library: String = "from Library") {
        self.imageTitle = imageTitle
        self.imageMessage = imageMessage
        self.videoTitle = videoTitle
        self.videoMessage = videoMessage
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


public struct BBOptionsUI {
    
    public var picker: BBPickerOptions
    public var banner: BBBannerOptions
    
    public init(picker: BBPickerOptions = BBPickerOptions(), banner: BBBannerOptions = BBBannerOptions()) {
        self.picker = picker
        self.banner = banner
    }
    
}
