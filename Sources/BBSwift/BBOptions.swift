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
    
    public var imageTitle: String
    public var imageMessage: String
    public var videoTitle: String
    public var videoMessage: String
    public var camera: String
    public var library: String
    
    public init(imageTitle: String? = nil, imageMessage: String? = nil, videoTitle: String? = nil, videoMessage: String? = nil, camera: String? = nil, library: String? = nil) {
        self.imageTitle = imageTitle ?? "pick_image".localized(bundle: .module)
        self.imageMessage = imageMessage ?? "pick_image_desc".localized(bundle: .module)
        self.videoTitle = videoTitle ?? "pick_video".localized(bundle: .module)
        self.videoMessage = videoMessage ?? "pick_video_desc".localized(bundle: .module)
        self.camera = camera ?? "pick_camera".localized(bundle: .module)
        self.library = library ??  "pick_library".localized(bundle: .module)
    }
}

public struct BBBannerOptions {
    
    public var apiErrorTitle: String
    
    public init(apiErrorTitle: String? = nil) {
        self.apiErrorTitle = apiErrorTitle ?? "api_error".localized(bundle: .module)
    }
}


public struct BBOptions {
    
    public var picker: BBPickerOptions
    public var logRequestMode: LogRequestMode
    public var banner: BBBannerOptions
    
    public init(picker: BBPickerOptions = BBPickerOptions(), logRequestMode: LogRequestMode = .none, banner: BBBannerOptions = BBBannerOptions()) {
        self.picker = picker
        self.logRequestMode = logRequestMode
        self.banner = banner
    }
    
}
