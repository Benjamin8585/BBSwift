//
//  ActivityIndicator.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import UIKit
import SwiftUI

/// SwiftUI version of activity indicator
public struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    
    public let style: UIActivityIndicatorView.Style
    
    public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style) {
        self._isAnimating = isAnimating
        self.style = style
    }

    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
