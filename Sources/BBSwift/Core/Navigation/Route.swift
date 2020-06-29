//
//  Route.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import SwiftUI
import UIKit

public protocol Route {
    
    associatedtype RoutedView: View
    
    /// Return the view to be pushed/presented by the router
    func associatedView() -> RoutedView
    
    /// Return the status bar style of the view to be push/presented
    func statusBarStyle() -> UIStatusBarStyle
    
}
