//
//  PopupModifier.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 25/06/2020.
//

import Foundation
import SwiftUI

public enum ClosingMode {
    case noTap, backgroundOnly, popupOnly, onTap
}

public struct PopupModifier: ViewModifier {

    @Binding var showPopup: Bool
    var backgroundColor: Color
    var closingMode: ClosingMode
    
    public func body(content: Content) -> some View {
        ZStack {
            if self.showPopup {
                ZStack {
                    backgroundColor.edgesIgnoringSafeArea(.all).onTapGesture {
                        if self.closingMode == .backgroundOnly {
                            self.showPopup = false
                        }
                    }
                    content.contentShape(Rectangle()).onTapGesture {
                        if self.closingMode == .popupOnly {
                            self.showPopup = false
                        }
                    }
                }
            }
        }.contentShape(Rectangle()).onTapGesture {
            if self.closingMode == .onTap {
                self.showPopup = false
            }
        }
    }

}
