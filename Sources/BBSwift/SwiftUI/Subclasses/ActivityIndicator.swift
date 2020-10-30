//
//  ActivityIndicator.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
#if os(iOS)
import UIKit
import SwiftUI


/// SwiftUI version of activity indicator
public struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    
    public var color: Color?
    public let style: UIActivityIndicatorView.Style
    
    public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style, color: Color? = nil) {
        self._isAnimating = isAnimating
        self.style = style
        self.color = color
    }

    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        if let color = color {
            view.color = color.uiColor()
        }
        return view
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        if let color = color {
            uiView.color = color.uiColor()
        }
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
#endif
