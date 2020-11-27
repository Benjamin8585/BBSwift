//
//  PopupModifier.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

public struct PopupModifier: ViewModifier {

    @Binding var showPopup: Bool
    var backgroundColor: Color
    var closeOnTap: Bool
    
    public func body(content: Content) -> some View {
        ZStack {
            if self.showPopup {
                ZStack {
                    backgroundColor.edgesIgnoringSafeArea(.all).onTapGesture {
                        if self.closeOnTap {
                            self.showPopup = false
                        }
                    }
                    content
                }
            }
        }
    }

}
