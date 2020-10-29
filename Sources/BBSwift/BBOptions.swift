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


public struct BBOptions {
    
    public var logRequestMode: LogRequestMode
    
    public init(logRequestMode: LogRequestMode = .none) {
        self.logRequestMode = logRequestMode
    }
    
}
