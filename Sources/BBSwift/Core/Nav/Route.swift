//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/10/30.
//

#if os(iOS)

import Foundation
import SwiftUI
import UIKit

public protocol RoutingCompatible {
    
    associatedtype RoutedView: View
    
    /// Return the view to be pushed/presented by the router
    func associatedView() -> RoutedView
    
    /// Return the status bar style of the view to be push/presented
    func statusBarStyle() -> UIStatusBarStyle
    
}

#endif
