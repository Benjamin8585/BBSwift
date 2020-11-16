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
        self.imageTitle = imageTitle ?? NSLocalizedString("pick_image", tableName: nil, bundle: .module, comment: "")
        self.imageMessage = imageMessage ?? NSLocalizedString("pick_image_desc", tableName: nil, bundle: .module, comment: "")
        self.videoTitle = videoTitle ?? NSLocalizedString("pick_video", tableName: nil, bundle: .module, comment: "")
        self.videoMessage = videoMessage ?? NSLocalizedString("pick_video_desc", tableName: nil, bundle: .module, comment: "")
        self.camera = camera ?? NSLocalizedString("pick_camera", tableName: nil, bundle: .module, comment: "")
        self.library = library ?? NSLocalizedString("pick_library", tableName: nil, bundle: .module, comment: "")
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
