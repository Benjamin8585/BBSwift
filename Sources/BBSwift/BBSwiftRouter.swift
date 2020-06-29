//
//  File.swift
//  
//
//  Created by Benjamin Bourasseau on 2020/06/29.
//

import Foundation

public struct BBSwiftRouter<T: RoutingCompatible> {
    
    var mainRouter: Router<T>
    
    init(navigation: NavigationController) {
        self.mainRouter = Router<T>(root: navigation)
    }
}

extension BBSwiftRouter {
    
    func action() -> () {
        return self.mainRouter.pop(animated: true)
    }
    
    /// Return a default back button
    func backButton(title: String) -> BackButton {
        return BackButton(title: title, action: self.action, color: BBColor.Text.lightBlack)
    }
}
