//
//  Router.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/10/30.
//

#if os(iOS)

import Foundation
import UIKit
import SwiftUI

public class NavigationController: UINavigationController {

    public var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}

public class Router<Route: RoutingCompatible> {

    public let root: NavigationController
    public var presentedModal: NavigationController?

    public init(root: NavigationController) {
        self.root = root
    }

    /// System to track status bars
    public var statusBarStack: [UIStatusBarStyle] = []

    /// Push a view
    private func push<Content: View>(view: Content, animated: Bool = true, statusBarStyle: UIStatusBarStyle = .default, transition: CATransition? = nil) {
        self.statusBarStack.append(root.preferredStatusBarStyle)
        self.root.statusBarStyle = statusBarStyle
        let hosting = UIHostingController(rootView: view)
        if let presented = self.root.presentedViewController as? UINavigationController {
            if let transition = transition {
                presented.view.layer.add(transition, forKey: nil)
            }
            presented.pushViewController(hosting, animated: animated)
        } else {
            if let transition = transition {
                self.root.view.layer.add(transition, forKey: nil)
            }
            self.root.pushViewController(hosting, animated: animated)
        }
    }

    /// Replace root viw and erase everything
    private func setRootNavigation<Content: View>(view: Content, animated: Bool = true, statusBarStyle: UIStatusBarStyle = .lightContent) {
        let hosting = UIHostingController(rootView: view)
        self.root.setViewControllers([hosting], animated: animated)
        statusBarStack = []
        self.root.statusBarStyle = statusBarStyle
    }

    /// Pop the current view
    public func pop(animated: Bool = true, transition: CATransition? = nil) {
        if let presented = self.root.presentedViewController as? UINavigationController {
            if let transition = transition {
                presented.view.layer.add(transition, forKey: nil)
            }
            presented.popViewController(animated: animated)
        } else {
            if let transition = transition {
                self.root.view.layer.add(transition, forKey: nil)
            }
            self.root.popViewController(animated: animated)
        }
        let statusBar = self.statusBarStack.popLast() ?? .default
        self.root.statusBarStyle = statusBar
    }

    /// Pop to root view of navigation
    public func popToRoot(animated: Bool = true) {
        self.root.popToRootViewController(animated: animated)
        let statusBar = self.statusBarStack.first ?? .default
        self.root.statusBarStyle = statusBar
        self.statusBarStack = []
    }

    /// Dissmiss current modal
    public func dissmissCurrent(animated: Bool = true, completion: (() -> Void)? = {}) {
        self.presentedModal = nil
        self.root.dismiss(animated: animated, completion: completion)
    }
    
    /// Return a default back button
    public func backButton(title: String) -> BackButton {
        return BackButton(title: title, action: { self.pop() }, color: nil)
    }

}

public extension Router {

    /// Push the route provided
    func push(route: Route) {
        self.push(view: route.associatedView(), statusBarStyle: route.statusBarStyle())
    }

    /// Push the route provided, but on the left side
    func pushLeft(route: Route) {
        self.push(view: route.associatedView(), statusBarStyle: route.statusBarStyle(), transition: CATransition.popFromLeft())
    }

    /// Replace current navigation by the current route
    func setRoot(route: Route) {
        self.setRootNavigation(view: route.associatedView(), statusBarStyle: route.statusBarStyle())
    }

    /// Present the route modally
    func showModal(route: Route, style: UIModalPresentationStyle = .automatic, animated: Bool = true, completion: (() -> Void)? = {}) {
        let hosting = UIHostingController(rootView: route.associatedView())
        hosting.modalPresentationStyle = style
        let nav = NavigationController(rootViewController: hosting)
        self.presentedModal = nav
        self.root.present(nav, animated: animated, completion: completion)
    }

}

#endif
