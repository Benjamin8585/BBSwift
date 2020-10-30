//
//  UIApplication.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

#if os(iOS)
import Foundation
import UIKit

public extension UIApplication {
    
    /// Close the current keyboard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
