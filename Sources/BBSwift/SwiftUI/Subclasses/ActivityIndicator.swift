//
//  ActivityIndicator.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
#if !os(macOS)
import UIKit
import SwiftUI

/// SwiftUI version of activity indicator
public struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
#endif
