//
//  View.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import SwiftUI

/// MARK: Modifiers

public extension View {
     /// Returns a type-erased version of the view.
    var typeErased: AnyView { AnyView(self) }
}

public extension View {
    
    /// Add a banner to the view
    func banner(data: Binding<BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
    
    /// Add an image picker to the view
    func imagePickable(image: Binding<UIImage?>) -> some View {
        self.modifier(ImagePickerModifier(image: image))
    }
    
    /// Add a video picker to the view
    func videoPickable(video: Binding<Data?>) -> some View {
        self.modifier(VideoPickerModifier(video: video))
    }
    
    /// Transform the view as a popup
    func popupify(showPopup: Binding<Bool>, backgroundColor: Color = Color.black.opacity(0.4), closeOnTap: Bool = false) -> some View {
        self.modifier(PopupModifier(showPopup: showPopup, backgroundColor: backgroundColor, closeOnTap: closeOnTap))
    }
}

/// MARK: Router stack
public extension View {

    /// Get the current navigation controller
    var rootVC: UINavigationController? {
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene as? UIWindowScene,
            let rootvc = sceneDelegate.windows.first?.rootViewController
                as? UINavigationController else { return nil }
        return rootvc
    }

    /// Shortcut to push views
    func push<Content: View>(view: Content, animated: Bool = true) {
        rootVC?.pushViewController(UIHostingController(rootView: view), animated: animated)
    }

    func setRootNavigation<Content: View>(view: Content, animated: Bool = true) {
        rootVC?.setViewControllers([UIHostingController(rootView: view)], animated: animated)
    }

    func pop(animated: Bool = true) {
        rootVC?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        rootVC?.popToRootViewController(animated: animated)
    }
}
